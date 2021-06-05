" Autoload functions for Mellow Statusline:
" <https://github.com/adigitoleo/vim-mellow-statusline>

function! mellow_statusline#Part(text, color, ...) abort
    let l:t_func = exists('v:t_func') ? v:t_func : type(function('type'))
    let l:t_string = exists('v:t_string') ? v:t_string : type('')
    let l:pad_left = repeat(' ', get(a:, 1, 0))
    let l:pad_right = repeat(' ', get(a:, 2, 0))

    if type(a:text) == l:t_func
        let l:text = l:pad_left .. a:text() .. l:pad_right
    elseif type(a:text) == l:t_string
        let l:text = l:pad_left .. a:text .. l:pad_right
    else
        throw 'mellow: wrong argument type for a:text'
    endif

    if type(a:color) == l:t_func
        let l:color = a:color(l:text)
    elseif type(a:color) == l:t_string
        let l:color = a:color
    else
        throw 'mellow: wrong argument type for a:color'
    endif
    return strlen(l:color) ? l:color .. l:text .. '%*' : l:text
endfunction


function! mellow_statusline#Mode(mode_map, lpad, rpad) abort
    let [l:color, l:text] = get(a:mode_map, mode())
    return mellow_statusline#Part(l:text, l:color, a:lpad, a:rpad)
endfunction


function! mellow_statusline#File(color, lpad) abort
    let l:file = &buftype != '' ? expand('%:t') : pathshorten(expand('%:~:.'))
    if get(g:, 'mellow_show_bufnr', 1)
        let l:file = bufnr() .. ':' .. l:file
    endif
    return mellow_statusline#Part(l:file, a:color, a:lpad)
endfunction


function! mellow_statusline#Flags(color, lpad) abort
    let l:flags = []
    if (&modifiable && &modified)
        call add(l:flags, '+')
    endif

    if &readonly
        call add(l:flags, 'RO')
    endif

    " Using join avoids adding extraneous spaces.
    return empty(l:flags) ? '' : mellow_statusline#Part(join(l:flags), a:color, a:lpad)
endfunction


function! mellow_statusline#FugitiveBranch(color, lpad) abort
    " Parse git branch name from Fugitive <https://github.com/tpope/vim-fugitive>.
    if exists('g:loaded_fugitive')
        let l:gitbranch = fugitive#statusline()
        let l:gitbranch = substitute(l:gitbranch, '[Git(', '[', '')
        let l:gitbranch = substitute(l:gitbranch, ')]', ']', '')
        return mellow_statusline#Part(l:gitbranch, a:color, a:lpad)
    endif
    return ''
endfunction


function! mellow_statusline#ALE(color, lpad) abort
    " Linter status, see <https://github.com/dense-analysis/ale#faq-statusline>.
    if (exists('b:ale_enabled') && !b:ale_enabled)
                \ || (exists('g:ale_enabled') && !g:ale_enabled)
        return ''
    endif

    let l:bufnr = bufnr()
    if ale#engine#IsCheckingBuffer(l:bufnr)
        let l:ale_msg = '...'
    else
        let l:counts = ale#statusline#Count(l:bufnr)
        let l:num_errors = l:counts.error + l:counts.style_error
        let l:num_warnings = l:counts.total - l:num_errors
        if l:num_errors == 0 && l:num_warnings == 0
            return ''
        endif
        let l:ale_msg = printf('%dW %dE', num_warnings, num_errors)
    endif
    return mellow_statusline#Part(l:ale_msg, a:color, a:lpad)
endfunction


function! mellow_statusline#CheckIndent(color, lpad) abort
    " Mixed indent or bad expandtab warning, see <https://github.com/millermedeiros/vim-statline>.
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
    return strlen(b:mellow_indent_warning) ?
                \ mellow_statusline#Part(b:mellow_indent_warning, a:color, a:lpad) : ''
 endfunction
