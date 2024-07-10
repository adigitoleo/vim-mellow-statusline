# Mellow Statusline


### A simple ASCII statusline for (neo)vim

## Screenshots

Taken on alacritty with LiberationMono font, using the [mellow] colorscheme:

<p align="center" style"margin: 4%;">
    <img src="./img/normal_mode.png" width="75%" />
    <img src="./img/insert_mode.png" width="75%" />
    <img src="./img/replace_mode.png" width="75%" />
    <img src="./img/visual_mode.png" width="75%" />
    <img src="./img/cmdline_mode.png" width="75%" />
    <img src="./img/term_zsh.png" width="75%" />
    <img src="./img/normal_mode_dark.png" width="75%" />
    <img src="./img/insert_mode_dark.png" width="75%" />
    <img src="./img/replace_mode_dark.png" width="75%" />
    <img src="./img/visual_mode_dark.png" width="75%" />
    <img src="./img/term_zsh_dark.png" width="75%" />
    <img src="./img/cmdline_mode_dark.png" width="75%" />
</p>


## Features

- Shortened buffer path with optional buffer number
- Fully configurable mode indicators (and their colors)
- Simple diagnostics included: mixed-indentation and trailing whitespace warnings
- Buffer and visual selection word counts for text and markdown files (or a
  custom list of filetypes)
- Integration with [ALE] or builtin NeoVim 0.8+ diagnostics API to display linter/LSP diagnostics
- Integration with [vim-fugitive] or [gitsigns.nvim] to display git HEAD name
- Integration with [gitsigns.nvim] to display git file status (NeoVim only)
- Support for custom diagnostic components (see `:h g:mellow_custom_parts`)
- Simple, monochromatic and clutter-free inactive buffer statusline
- Optional tabline with shortened buffer name and tabpage number


## Installation

Vim and NeoVim plugins are commonly installed using a plugin manager.
Many such exist in the wild. Modern (Neo)Vim versions also ship with a built-in
package loading functionality (read `:help packages` for details).

**After installing the plugin, please read `:help mellow-statusline` for information on usage and available options.**

The statusline should work with any colorscheme,
but it will require some setup unless the recommended [mellow] colorscheme is used.


## Other statusline plugins

- [airline]
- [lightline]
- [moonfly-statusline]
- [vim-statline]


[NOTE]: # ( ------------ PUT ALL EXTERNAL LINKS BELOW THIS LINE ------------ )

[mellow]: https://github.com/adigitoleo/vim-mellow

[ALE]: https://github.com/dense-analysis/ale

[airline]: https://github.com/vim-airline/vim-airline

[lightline]: https://github.com/itchyny/lightline.vim

[moonfly-statusline]: https://github.com/bluz71/vim-moonfly-statusline

[vim-statline]: https://github.com/millermedeiros/vim-statline

[vim-fugitive]: https://github.com/tpope/vim-fugitive

[gitsigns.nvim]: https://github.com/lewis6991/gitsigns.nvim
