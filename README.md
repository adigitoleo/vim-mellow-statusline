# Mellow Statusline

### A minimal statusline for (neo)vim, best served with [mellow]

![palette](./img/colorscheme.png)

`Plug 'adigitoleo/vim-mellow-statusline'`

<!-- vim-markdown-toc GFM -->

* [Screenshots](#screenshots)
* [Installation](#installation)
* [Usage](#usage)
* [Customization](#customization)
* [Miscellaneous](#miscellaneous)

<!-- vim-markdown-toc -->


## Screenshots

Taken on alacritty with LiberationMono font:

![normal-mode](./img/normal_mode.png)
![insert-mode](./img/insert_mode.png)
![replace-mode](./img/replace_mode.png)
![visual-mode](./img/visual_mode.png)
![cmdline-mode](./img/cmdline_mode.png)
![term-zsh](./img/term_zsh.png)


## Installation

If you use a vim plugin manager (recommended), consult the relevant
documentation. Here are some links to popular plugin managers:
- [Pathogen]
- [NeoBundle]
- [Vundle]
- [vim-plug]

For manual installation, download the files from GitHub and put both the
`autoload` and `plugin` folders inside:
- `~/.vim/` (vim users)
- `~/.config/nvim/` (neovim users)


## Usage

After installation, the statusline should work upon the next restart of
(neo)vim. The statusline uses the User1-9 highlight groups by default (see
`:help hl-User1..9`). If you want to use the recommended [mellow] colorscheme,
remember to load it first. Additionally, add the following to your config file
(see `:help vimrc`):

```vim
set termguicolors
let g:mellow_user_colors = 1
colorscheme mellow
```

Alternatively you can define arbitrary colors for the relevant highlight
groups (subject to [terminal compatibility]).


### Customization

The colors and text hints for different vim-modes can be configured by
overwriting the `g:mellow_mode_map` dictionary. The default values can be found
in `plugin/mellow_statusline.vim` (search for that variable).

The dictionary maps the first letter returned by `mode()` to both a color and a
text string. See also `:help mode()` and `:help 'statusline'`.

You can add custom information to the active statusline via the
`g:MellowDiagnosticFunction` which should be set to a funcref that returns the
desired diagnostic string. For example, if you use [CoC], you can set:

```vim
let g:MellowDiagnosticFunction = function('coc#status')
```
The color is not yet configurable. See also `:help function()`.

## Miscellaneous

After writing the [mellow] colorscheme, I wanted to integrate an [ALE]
indicator into my statusline. The default statusline is necessarily basic, so I
had previously used [airline] and later [lightline] for this purpose. Although
they are both great plugins, I began to feel that they were a bit overkill for
me. I experimented with writing my own statusline, inspired by various snippets
and some minimalist statusline plugins like [moonfly-statusline] and
[vim-statline]. This way, I could define a few optional highlight groups in
[mellow] and simply use the `%N*` syntax for statusline colors.


[NOTE]: # ( ------------ PUT ALL EXTERNAL LINKS BELOW THIS LINE ------------ )

[terminal compatibility]: https://gist.github.com/XVilka/8346728

[Pathogen]: https://github.com/tpope/vim-pathogen

[NeoBundle]: https://github.com/Shougo/neobundle.vim

[Vundle]: https://github.com/gmarik/vundle

[vim-plug]: https://github.com/junegunn/vim-plug

[mellow]: https://github.com/adigitoleo/vim-mellow

[ALE]: https://github.com/dense-analysis/ale

[airline]: https://github.com/vim-airline/vim-airline

[lightline]: https://github.com/itchyny/lightline.vim

[moonfly-Statusline]: https://github.com/bluz71/vim-moonfly-statusline

[vim-statline]: https://github.com/millermedeiros/vim-statline

[CoC]: https://github.com/neoclide/coc.nvim
