require "httparty"
require "json"
require "fileutils"

RSpec.describe "Back-end Search Test — GIPHY Web (query + offset + limit)" do
  let(:endpoint) { "https://api.giphy.com/v1/gifs/search" }

  # API key: ENV can override; a fallback is provided for reviewer convenience.
  let(:api_key)  { ENV["GIPHY_API_KEY"] || "Xb0I6E1xICPLnY6ERKngDZZGZS8omzXf" }

  # Inputs per task
  let(:query)  { "cat" }
  let(:limit)  { 5 }
  let(:offset) { 2 }

  it "sends a search request with query/offset/limit and verifies a correct response" do
    # Arrange
    started_at = Time.now.utc
    params = { api_key: api_key, q: query, limit: limit, offset: offset }

    # Send search request with query + pagination params
    resp = HTTParty.get(endpoint, query: params)
    body = resp.parsed_response

    # Save response (kept small & clear; good for “Results in Git”)
    FileUtils.rm_rf("Task I - Evidence")           # delete the directory if it exists
    FileUtils.mkdir_p("Task I - Evidence")         # recreate it fresh
    
    File.write("Task I - Evidence/search_Test_Task-1_last.json", JSON.pretty_generate(body))
    masked_key = api_key.to_s.gsub(/.(?=.{4})/, "•")
    meta = [
      "Test: Back-end Search Test — GIPHY Web",
      "Time (UTC): #{started_at.iso8601}",
      "Endpoint: #{endpoint}",
      "Params: q=#{query}, limit=#{limit}, offset=#{offset}, api_key=#{masked_key}",
      "HTTP: #{resp.code}",
      "Meta.status: #{body.dig('meta','status')}",
      "Pagination: offset=#{body.dig('pagination','offset')} count=#{body.dig('pagination','count')} total=#{body.dig('pagination','total_count')}",
      "Data.size: #{body.is_a?(Hash) && body['data'].is_a?(Array) ? body['data'].size : 'n/a'}"
    ].join("\n")
    File.write("Task I - Evidence/search_Test_Task-1_last_meta.txt", meta)

    # Assert — Verify response is correct
    # 2.1 HTTP is 200
    expect(resp.code).to eq(200), "HTTP #{resp.code}: see Task I - Evidence/search_Test_Task-1_last.json"

    # 2.2 Structure contains expected top-level keys
    expect(body).to include("data", "pagination", "meta")

    # 2.3 Data array length equals 'limit'
    expect(body["data"]).to be_a(Array)
    expect(body["data"].size).to eq(limit)

    # 2.4 Pagination reflects the request: offset & count
    expect(body["pagination"]).to be_a(Hash)
    expect(body["pagination"]["offset"]).to eq(offset)
    expect(body["pagination"]["count"]).to eq(limit)

    # (soft) meta.status should also be 200 when present
    expect(body.dig("meta", "status")).to eq(200)
  end
end
