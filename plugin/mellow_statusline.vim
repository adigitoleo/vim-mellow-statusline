""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Minimal statusline for (neo)vim, best served with the mellow colorscheme.
" Maintainer: adigitoleo <adigitoleo@protonmail.com>
" Version: 0.2
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


if exists('g:loaded_mellow_statusline')
    finish
endif
let g:loaded_mellow_statusline = 1


if has("nvim")
    let s:normal = "nvim"
elseif has("gui_running")
    let s:normal = "gvim"
else
    let s:normal = "vim"
endif

" Define mode colors and strings.
let g:mellow_mode_map = get(g:, "mellow_mode_map",
            \{
            \  "n":         ["%5*", s:normal ],
            \  "i":         ["%6*", "insert"],
            \  "R":         ["%8*", "r-mode"],
            \  "v":         ["%7*", "visual"],
            \  "V":         ["%7*", "v-line"],
            \  "\<C-v>":    ["%7*", "v-rect"],
            \  "c":         ["%9*", "cmdline"],
            \  "r":         ["%9*", "cmdline"],
            \  "!":         ["%9*", "cmdline"],
            \  "s":         ["%7*", "select"],
            \  "S":         ["%7*", "s-line"],
            \  "\<C-s>":    ["%7*", "s-rect"],
            \  "t":         ["%9*", "term"],
            \})


function! MellowStatusline(is_active) abort
    let l:statusline = ''

    " Construct format string, using %(...%) to hide optional blocks.
    if a:is_active
        " Mode indicator, colors are dynamic so DON'T USE A %{} BLOCK.
        let l:statusline .= mellow_statusline#Mode(g:mellow_mode_map)
        " Short file path.
        let l:statusline .= '%( %1*%{mellow_statusline#File()}%<%*%)'
        " Special file flags.
        let l:statusline .= '%( %3*%{mellow_statusline#Flags()}%*%)'
        " Git branch indicator.
        let l:statusline .= '%( %4*%{mellow_statusline#GitBranch()}%*%)'
        " Switch to left side.
        let l:statusline .= '%='
        " Line and column numbers.
        let l:statusline .= '%1*%l,%c%V%*'
        " ALE linter status.
        let l:statusline .= '%( %3*%{mellow_statusline#ALE()}%*%)'
        " Custom diagnostic function.
        if exists('g:MellowDiagnosticFunction')
            let l:statusline .= '%( %3*%{g:MellowDiagnosticFunction()}%*%)'
        endif
        " Indentation warnings.
        let l:statusline .= '%( %3*%{mellow_statusline#CheckIndent()}%*%)'
        " File type (TODO: add input indicator).
        let l:statusline .= '%( %1*%{&ft}%*%)'
        " Add trailing space (balances leading space before mode indicator).
        let l:statusline .= ' '
    else
        " Inactive statusline: subset of the above, without %User* colors.
        let l:statusline .= '%( %{mellow_statusline#File()}%<%)'
        let l:statusline .= '%( %{mellow_statusline#Flags()}%)'
        let l:statusline .= '%='
        let l:statusline .= '%l,%c%V'
        let l:statusline .= ' '
    endif

    return l:statusline
endfunction


function! s:UpdateInactiveStatuslines() abort
" From https://github.com/bluz71/vim-moonfly-statusline
" Iterate over windows and set inactive statuslines, required at startup.
    for winnum in range(1, winnr('$'))
        if winnum != winnr()
            call setwinvar(winnum, '&statusline', '%!MellowStatusline(v:false)')
        endif
    endfor
endfunction


augroup mellow_statusline
    " Autocommands for setting the statusline.
    autocmd!
    autocmd CursorHold,BufWritePost * unlet! b:mellow_indent_warning
    autocmd VimEnter * call s:UpdateInactiveStatuslines()
    autocmd WinEnter,BufWinEnter * setlocal statusline=%!MellowStatusline(v:true)
    autocmd WinLeave * setlocal statusline=%!MellowStatusline(v:false)
augroup END
