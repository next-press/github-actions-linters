# github-actions-linters
Common linters for WordPress plugins and themes

## How to use
Create the `.github/workflows/main.yml` file with this content:

```
name: CI

on: [push, pull_request]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Lint PHP
      uses: next-press/github-actions-linters/actions/phpcs@master
    - name: Lint JS
      uses: next-press/github-actions-linters/actions/eslint@master
    - name: Lint SCSS
      uses: next-press/github-actions-linters/actions/stylelint-scss@master
```