# Mellow Statusline

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
remember to load it as well. For example, add the following to your config file
(see `:help vimrc`):

```vim
set termguicolors
let g:mellow_user_colors = 1
colorscheme mellow
```

Alternatively you can define arbitrary colors for the relevant highlight
groups (subject to [terminal compatibility]).


### Customization
<!-- vim-markdown-toc GFM -->

* [Miscellaneous](#miscellaneous)

<!-- vim-markdown-toc -->

The colors and text hints for different vim-modes can be configured by
overwriting the `g:mellow_mode_map` dictionary. The default values can be found
in `plugin/mellow_statusline.vim` (search for that variable).

The dictionary maps the first letter returned by `mode()` to both a color and a
text string. See also `:help mode()` and `:help 'statusline'`.

**The `g:MellowDiagnosticFunction` support was removed in a recent commit.**
Instructions on how to set up custom diagnostic components,
and more comprehensive documentation overall, will be produced before the v1 release (shortly).
If you're curious, take a look at the autoload function `mellow_statusline#Part`,
which will provide the new framework for this.

Here's a vimrc snippet example which adds a clock to the statusbar:

```vim
let g:mellow_custom_parts = [
            \ [function('strftime', ['%H:%M']), '%2*', 1, 0],
            \]

```

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

[vim-fugitive]: https://github.com/tpope/vim-fugitive
