"                  __ __
"    _  _    ___  /  /  /______    ___
"   / \/ \  / _ \/  /  / _  \  \/\/  /
"  /      \/ ___/  /  / /_/ /\      /
" /__/\/\__\___/__/__/\____/  \_/\_/ statusline

" Maintainer: adigitoleo <adigitoleo@posteo.net>
" Description: A minimal statusline for (neo)vim, best served with the mellow colorscheme.
" Homepage: https://github.com/adigitoleo/vim-mellow-statusline


if exists('g:loaded_mellow_statusline')
    finish
endif
let g:loaded_mellow_statusline = 1


if has('nvim')
    let s:normal = 'nvim'
elseif has('gui_running')
    let s:normal = 'gvim'
else
    let s:normal = 'vim'
endif

let s:git_enabled = get(g:, 'mellow_git_enabled', v:true)
let s:diagnostics_enabled = get(g:, 'mellow_diagnostics_enabled', v:true)
let s:wordcount_enabled = get(g:, 'mellow_wordcount_enabled', [
            \ 'text', 'markdown'
            \])
let s:tabline_enabled = get(g:, 'mellow_tabline', v:true)
let s:mode_map = {
            \  'n':         ['%5*', s:normal ],
            \  'i':         ['%6*', 'insert'],
            \  'R':         ['%8*', 'replace'],
            \  'v':         ['%7*', 'visual'],
            \  'V':         ['%7*', 'v-line'],
            \  '':        ['%7*', 'v-rect'],
            \  'c':         ['%9*', 'cmdline'],
            \  'r':         ['%9*', 'cmdline'],
            \  '!':         ['%9*', 'cmdline'],
            \  's':         ['%7*', 'select'],
            \  'S':         ['%7*', 's-line'],
            \  '':        ['%7*', 's-rect'],
            \  't':         ['%9*', 'term'],
            \}

if exists('g:mellow_mode_map')
    call extend(s:mode_map, g:mellow_mode_map)
endif


function! MellowStatusline(is_active) abort
    let l:statusline = ''

    if a:is_active
        let l:statusline .= mellow_statusline#Mode(s:mode_map, 1, 1)
        let l:statusline .= mellow_statusline#File('', 1)
        let l:statusline .= mellow_statusline#Flags ('%1*', 1)
        if s:git_enabled
            let l:statusline .= mellow_statusline#GitHead('%3*', 1)
        endif
        let l:statusline .= '%='
        let l:statusline .= ' %l,%c%V'
        if exists('g:mellow_custom_parts')
            for spec in g:mellow_custom_parts
                let [l:Text, l:Color, l:lpad, l:rpad] = spec
                let l:statusline .= mellow_statusline#Part(l:Text, l:Color, l:lpad, l:rpad)
            endfor
        endif
        if indexof(s:wordcount_enabled, 'v:val == &ft') > -1
            let l:statusline .= mellow_statusline#WordCount('', 1)
        endif
        if s:diagnostics_enabled
            let l:statusline .= mellow_statusline#Diagnostics('%1*', 1)
        endif
        let l:statusline .= mellow_statusline#WhitespaceCheck('%1*', 1)
        " File type (and encoding if not utf-8).
        if has('nvim')
            let l:statusline .= '%( %{&fenc !=# "utf-8" && &ft ? &fenc .. " | " .. &ft : &ft}%)'
        else
            let l:statusline .= '%( %{&fenc !=# "utf-8" && &ft ? &fenc . " | " . &ft : &ft}%)'
        endif
        let l:statusline .= ' '
    else
        " Monochromatic subset of the above.
        let l:statusline .= ' %{mellow_statusline#File("", 0)}'
        let l:statusline .= ' %{mellow_statusline#Flags("", 0)}'
        let l:statusline .= '%='
        let l:statusline .= '%l,%c%V'
        if has('nvim')
            let l:statusline .= '%( %{&fenc !=# "utf-8" && &ft ? &fenc .. " | " .. &ft : &ft}%)'
        else
            let l:statusline .= '%( %{&fenc !=# "utf-8" && &ft ? &fenc . " | " . &ft : &ft}%)'
        endif
        let l:statusline .= ' '
    endif

    return l:statusline
endfunction


function! MellowTabline() abort
    let l:tabline = ''

    for l:tabpage in range(1, tabpagenr('$'))
        if l:tabpage  ==# tabpagenr()
            let l:tabline .= '%4*[%' . l:tabpage . 'T' . l:tabpage . '] %*'
            let l:tabline .= mellow_statusline#TabFile('%1*', '%#TabLineSel#', l:tabpage)
        else
            let l:tabline .= '%#TabLine#[' . l:tabpage . '] '
            let l:tabline .= '%' . l:tabpage . 'T'
            let l:tabline .= mellow_statusline#TabFile('', '%#TabLine#', l:tabpage)
        endif
    endfor
    let l:tabline .= '%#TabLineFill#%T'

    if tabpagenr('$') > 1
        let l:tabline .= '%=%#TabLine#%999X[X]'
    endif

    return l:tabline
endfunction


if s:tabline_enabled
    set tabline=%!MellowTabline()
endif


function! s:UpdateInactiveStatuslines() abort
" From <https://github.com/bluz71/vim-moonfly-statusline>, MIT license.
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
    autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:mellow_whitespace_warning
    autocmd VimEnter * call s:UpdateInactiveStatuslines()
    autocmd WinEnter,BufWinEnter * setlocal statusline=%!MellowStatusline(v:true)
    autocmd WinLeave * setlocal statusline=%!MellowStatusline(v:false)
augroup END
