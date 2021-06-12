# Mellow Statusline


### A simple ASCII statusline for (neo)vim

`Plug 'adigitoleo/vim-mellow-statusline', { 'tag': '*' }`


## Screenshots

Taken on alacritty with LiberationMono font, using the [mellow] colorscheme:

<p align="center" style"margin: 4%;">
    <img src="./img/normal_mode.png" width="48%" />
    <img src="./img/normal_mode_dark.png" width="48%" />
    <img src="./img/insert_mode.png" width="48%" />
    <img src="./img/insert_mode_dark.png" width="48%" />
    <img src="./img/replace_mode.png" width="48%" />
    <img src="./img/replace_mode_dark.png" width="48%" />
    <img src="./img/visual_mode.png" width="48%" />
    <img src="./img/visual_mode_dark.png" width="48%" />
    <img src="./img/cmdline_mode.png" width="48%" />
    <img src="./img/cmdline_mode_dark.png" width="48%" />
    <img src="./img/term_zsh.png" width="48%" />
    <img src="./img/term_zsh_dark.png" width="48%" />
</p>


## Features

- Shortened buffer path with optional buffer number
- Fully configurable colors and mode indicators
- Simple diagnostics included: mixed-indentation and trailing whitespace warnings
- Integration with [ALE] and [vim-fugitive] to display linter diagnostics and git branch
- Support for custom diagnostic components
- Simple, monochromatic and clutter-free inactive buffer statusline


## Installation

If you use a vim plugin manager, consult the relevant documentation.
Here are some links to popular plugin managers:
- [Pathogen]
- [NeoBundle]
- [Vundle]
- [vim-plug]

Alternatively, check [the helpfile] for native package loading instructions.

[the helpfile]: doc/mellow-statusline.txt

**After installing the colorscheme, please read `:help mellow-statusline` for information on usage and available options.**

The statusline should work with any colorscheme,
but it will require some setup unless the recommended [mellow] colorscheme is used.


## Other statusline plugins

- [airline]
- [lightline]
- [moonfly-statusline]
- [vim-statline]


[NOTE]: # ( ------------ PUT ALL EXTERNAL LINKS BELOW THIS LINE ------------ )

[Pathogen]: https://github.com/tpope/vim-pathogen

[NeoBundle]: https://github.com/Shougo/neobundle.vim

[Vundle]: https://github.com/gmarik/vundle

[vim-plug]: https://github.com/junegunn/vim-plug

[mellow]: https://github.com/adigitoleo/vim-mellow

[ALE]: https://github.com/dense-analysis/ale

[airline]: https://github.com/vim-airline/vim-airline

[lightline]: https://github.com/itchyny/lightline.vim

[moonfly-statusline]: https://github.com/bluz71/vim-moonfly-statusline

[vim-statline]: https://github.com/millermedeiros/vim-statline

[vim-fugitive]: https://github.com/tpope/vim-fugitive
