# Contributing to KeyValueTable

First off, thank you for considering contributing to `key_value_table`! 🎉

Contributions from the open-source community make this package better for everyone. Whether you're fixing a bug, proposing a new layout customization, or improving documentation, your help is warmly welcomed.

---

## Code of Conduct

By participating in this project, you agree to abide by the terms of our [Code of Conduct](CODE_OF_CONDUCT.md). Please report any unacceptable behavior to the project maintainers.

---

## How Can I Contribute?

### 1. Reporting Bugs
- **Check existing issues:** Before opening a new issue, please search the [Issue Tracker](https://github.com/Amrit1345/key_value_table/issues) to verify that the bug hasn't already been reported.
- **Provide reproduction details:**
  - Clear summary and steps to reproduce.
  - Expected vs. actual behavior.
  - Flutter & Dart version (`flutter --version`).
  - Target platforms (Android, iOS, Web, macOS, Linux, Windows).
  - Minimal code snippet or widget tree illustrating the issue.

### 2. Suggesting Enhancements
Feature requests are always welcome!
- Explain **why** this feature would be useful to other developers.
- Describe the proposed API or visual behavior.
- Reference any relevant UI standards (Material 3, Apple HIG, Stripe design system, etc.).

### 3. Submitting Pull Requests
We welcome pull requests for bug fixes, performance improvements, and new features!

---

## Local Development Workflow

### 1. Fork & Clone
```bash
# Clone your fork
git clone https://github.com/<your-username>/key_value_table.git
cd key_value_table

# Create a feature or bugfix branch
git checkout -b feature/my-cool-feature
```

### 2. Install Dependencies
```bash
# Install root package dependencies
flutter pub get

# Install example app dependencies
cd example
flutter pub get
cd ..
```

### 3. Run Automated Tests
All unit and widget tests must pass before submitting a PR:
```bash
# Run root package tests
flutter test

# Run example app tests
cd example && flutter test && cd ..
```

### 4. Verify Code Quality & Lints
```bash
# Ensure 0 errors and 0 warnings
flutter analyze --fatal-infos

# In example directory
cd example && flutter analyze --fatal-infos && cd ..
```

### 5. Format Code
Ensure code adheres to standard Dart formatting:
```bash
dart format .
```

---

## Pull Request Guidelines

1. **Keep PRs focused:** Submit smaller, focused pull requests rather than huge, sweeping changes whenever possible.
2. **Add tests:** If you add new functionality or fix a bug, please include corresponding tests in `test/key_value_table_test.dart` to prevent regressions.
3. **Update documentation:**
   - Update `README.md` if public API or props change.
   - Add a brief note in `CHANGELOG.md` under the upcoming version header.
   - Include Dart doc comments (`///`) on any new public classes, methods, or properties.
4. **Follow conventions:** Keep commit messages concise and descriptive (e.g. `feat: add support for custom divider padding` or `fix: handle empty map gracefully`).

Thank you for helping make `key_value_table` great! 🚀

