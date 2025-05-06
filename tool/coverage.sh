#!/bin/bash

# Run the test coverage
dart run test_cov_console | tee coverage_report.txt

# Add timestamp to the report
sed -i '' "1s/.*/Test Coverage Report\nGenerated on: $(date)/" coverage_report.txt

echo "Coverage report has been saved to coverage_report.txt" 