# phynd_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Running Tests and Coverage Reports

To run tests with coverage reports, you can use the following commands:

### Text-based Coverage Report
```bash
flutter test --coverage && dart test/coverage_report.dart
```
This will generate a text-based coverage report at `coverage/coverage_report.txt`

### HTML Coverage Report
```bash
flutter test --coverage && genhtml coverage/lcov.info -o coverage/html
```
This will generate an HTML coverage report in the `coverage/html` directory. Note: This requires `lcov` to be installed on your system.

### Console Coverage Report
```bash
bash tool/coverage.sh
```
This will:
- Run all tests
- Generate a coverage report
- Display the report in the console
- Save the report to `coverage_report.txt`


  