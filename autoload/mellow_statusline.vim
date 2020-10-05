""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions for vim-mellow-statusline components.
" Maintainer: adigitoleo <adigitoleo@protonmail.com>
" see also: ../plugin/mellow_statusline.vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! mellow_statusline#Mode(mode_map) abort
    " Mode indicator for the active (FIX) statusline.
    let l:mode = mode()
    let [mode_color, mode_text] = a:mode_map[l:mode]
    return join([mode_color, mode_text, '%*'])
endfunction


function! mellow_statusline#File() abort
    " Shorter file/buffer identifier.
    if &buftype != ''
        return expand('%:t')
    else
        return pathshorten(expand('%:~'))
    endif
endfunction


function! mellow_statusline#Flags() abort
    " File flags (modified, readonly).
    let l:flags = []
    if (&modifiable && &modified)
        call add(l:flags, '+')
    endif

    if &readonly
        call add(l:flags, 'RO')
    endif

    " Using join avoids adding extraneous spaces.
    return join(l:flags)
endfunction


function! mellow_statusline#GitBranch() abort
    " Parse git branch name from Fugitive.
    let l:gitbranch = exists("g:loaded_fugitive")?fugitive#statusline():""
    let l:gitbranch = substitute(l:gitbranch, '[Git(', '', '')
    let l:gitbranch = substitute(l:gitbranch, ')]', '', '')
    return l:gitbranch
endfunction


function! mellow_statusline#ALE() abort
    " Linter status, see https://github.com/dense-analysis/ale#faq-statusline
    if (exists('b:ale_enabled') && !b:ale_enabled)
                \ || (exists('g:ale_enabled') && !g:ale_enabled)
        return ''
    endif

    if ale#engine#IsCheckingBuffer(bufnr())
        return '...'
    endif

    let l:counts = ale#statusline#Count(bufnr())
    let l:num_errors = l:counts.error + l:counts.style_error
    let l:num_warnings = l:counts.total - l:num_errors

    return printf('%dW %dE', num_warnings, num_errors)
endfunction


function! mellow_statusline#CheckIndent() abort
    " Mixed indent or bad expandtab warning.
    " See https://github.com/millermedeiros/vim-statline
    if !exists('b:mellow_indent_warning')
        let b:mellow_indent_warning = ''

        if !&modifiable
            return b:mellow_indent_warning
        endif

        let l:tabs = search('^\t', 'nw') > 0
        let l:spaces = search('^ \+', 'nw') > 0

        if l:tabs && l:spaces
            let b:mellow_indent_warning = 'mixed indent'
        elseif l:spaces && !&expandtab
            let b:mellow_indent_warning = 'noexpandtab'
        elseif l:tabs && &expandtab
            let b:mellow_indent_warning = 'expandtab'
        endif
    endif
    return b:mellow_indent_warning
 endfunction
