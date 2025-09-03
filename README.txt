# Tellus – QA Automation Engineer Problem Set

This repository contains my solutions for the **Tellus QA Automation Engineer Problem Set**.  
The assignment is divided into three tasks: Search Test (Ruby/RSpec), SQL query, and Test Scenarios documentation.  
Each task is organized in its own folder for clarity.




## Repository Structure

TELLUS/
│
├── Task I - Evidence/         # Proof of Task I execution (API test results.Generated on every run, but not saved in the repository) 
│   ├── search_Test_Task-1_last.json
│   └── search_Test_Task-1_meta.txt
│
├── Task I - Search Test/     # Task I: Automated test in Ruby/RSpec
│   ├── giphy_search_test.rb  # Implements Task I (query, offset, limit check)
│   └── spec_helper.rb
│
├── Task II - SQL/            # Task II: SQL query
│   └── laptops_under_2000.sql
│
├── Task III - docs/          # Task III: Test design deliverables
│   ├── TRM.xlsx              # Test Requirements Matrix (high-level scenarios)
│   └── Test-4 Case.docx      # Detailed documented test case (T4)
│
├── Gemfile                   # Ruby dependencies
├── Gemfile.lock              # Locked dependency versions
├── .rspec                    # RSpec config (formatting + load path)
├── .ruby-version             # Ruby version used
└── README.md                 # This file

## Task I – Search Test (Ruby/RSpec)
 **Goal:** Implement Search Test for GIPHY API, verifying **query, limit, and offset** parameters.  
 **Steps performed by test:**  
  1. Sends a search request with `q`, `limit`, `offset`.  
  2. Verifies response is **HTTP 200**, structure includes `data/pagination/meta`, and pagination values match.  
  3. Saves artifacts (`json` + `meta.txt`) into `artifacts/` for proof.  

##  Task II – SQL
- **Goal:** Select all laptop product names where average price < 2000.  
- **Location:** `Task II - SQL/laptops_under_2000.sql`

sql
SELECT product_name
FROM products
WHERE product_type = 'laptop'
GROUP BY product_name
HAVING AVG(price) < 2000;

## Task III – Test Scenarios
 **Goal 1:** Cover Search functionality for GIPHY Web app with high-level scenarios.  
  - See `TRM.xlsx` (scope, acceptance criteria, severity, priority, automation estimates).  

 **Goal 2:** Provide one detailed documented test case.  
  - See `Test-4 Case.docx` → detailed breakdown of Test Case 4 (API: search with query/offset/limit).  

##  Notes
- Ruby version: see `.ruby-version` (3.4.5 used).  
- GIPHY API key: test uses a fallback demo key; can be overridden with `GIPHY_API_KEY` environment variable.  
- Data is dynamic: assertions validate structure and pagination, not specific GIF content.  

##  Author
Hristo Margov  
Solution prepared for the Tellus QA Automation Engineer assignment.
