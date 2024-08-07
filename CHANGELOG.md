# Changelog

All notable changes to this project (after v1.0.0) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] : 2024-07-11

### Added
- Support for word counts using the built-in API in modern (Neo)Vim versions.

## [2.0.0] : 2024-02-22

### Added
- NeoVim builtin diagnostics API support, so that ALE can be replaced by e.g.
  nvim-lspconfig on NeoVim to provide the same diagnostics.

### Changed
- user options, which now do not support individual toggles for Fugitive or
  gitsigns; a simpler set of options now toggles high-level functionality such
  as "git integration" or "diagnostics integration" instead of individual
  plugin integrations

## [1.3.0] : 2023-04-08

### Added
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) integration,
  allowing for git file status indicator (and optional replacement of git HEAD
  indicator from Fugitive).

## [1.2.1] : 2023-03-23

### Fixed
- Fixed bufnr errors in vim8 ALE integration

## [1.2] : 2023-01-28

### Added
- Tabline integration, i.e. `'tabline'` setting.

## [1.1] : 2022-11-02

### Changed
- Add support for vim8 by fixing syntax errors

## [1.0.1] : 2021-06-20

### Fixed
- Fixed E714 error when entering visual- and select-blockwise mode.

## [1.0.0] : 2021-06-14

Version 1.0.0 release!

Check the README.md for a list of features.
Check [the helpfile](doc/mellow-statusline.txt) for an overview of the options.
