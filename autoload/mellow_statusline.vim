" Autoload functions for Mellow Statusline:
" <https://github.com/adigitoleo/vim-mellow-statusline>

function! mellow_statusline#Part(text, color, ...) abort
    let l:t_func = exists('v:t_func') ? v:t_func : type(function('type'))
    let l:t_string = exists('v:t_string') ? v:t_string : type('')
    let l:pad_left = repeat(' ', get(a:, 1, 0))
    let l:pad_right = repeat(' ', get(a:, 2, 0))

    if type(a:text) == l:t_func
        let l:text_raw = a:text()
    elseif type(a:text) == l:t_string
        let l:text_raw = a:text
    else
        throw 'mellow: wrong argument type for a:text'
    endif

    if strlen(l:text_raw)
        if has('nvim')
            let l:text = l:pad_left . l:text_raw . l:pad_right
        else
            let l:text = l:pad_left . l:text_raw . l:pad_right
        endif
    else
        return ''
    endif

    if type(a:color) == l:t_func
        let l:color = a:color(l:text)
    elseif type(a:color) == l:t_string
        let l:color = a:color
    else
        throw 'mellow: wrong argument type for a:color'
    endif
    if has('nvim')
        return strlen(l:color) ? l:color . l:text . '%*' : l:text
    else
        return strlen(l:color) ? l:color . l:text . '%*' : l:text
    endif
endfunction


function! mellow_statusline#Mode(mode_map, lpad, rpad) abort
    let [l:color, l:text] = get(a:mode_map, mode())
    return mellow_statusline#Part(l:text, l:color, a:lpad, a:rpad)
endfunction


function! mellow_statusline#File(color, lpad) abort
    let l:file = &buftype !=# '' ? expand('%:t') : pathshorten(expand('%:~:.'))
    if get(g:, 'mellow_show_bufnr', 1)
        if has('nvim')
            let l:file = bufnr() . ':' . l:file
        else
            let l:file = bufnr('%') . ':' . l:file
        endif
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

    return mellow_statusline#Part(join(l:flags), a:color, a:lpad)
endfunction


function! mellow_statusline#FugitiveBranch(color, lpad) abort
    " Parse git branch name from Fugitive <https://github.com/tpope/vim-fugitive>.
    let l:gitbranch = ''
    if exists('g:loaded_fugitive')
        let l:gitbranch = fugitive#statusline()
        let l:gitbranch = substitute(l:gitbranch, '[Git(', '[', '')
        let l:gitbranch = substitute(l:gitbranch, ')]', ']', '')
    endif
    return mellow_statusline#Part(l:gitbranch, a:color, a:lpad)
endfunction


function! mellow_statusline#ALE(color, lpad) abort
    " Linter status, see <https://github.com/dense-analysis/ale#faq-statusline>.
    let l:ale_msg = ''
    if exists('g:ale_enabled') && g:ale_enabled
        if !exists('b:ale_enabled') || b:ale_enabled
            let l:bufnr = bufnr()
            if ale#engine#IsCheckingBuffer(l:bufnr)
                let l:ale_msg = '...'
            else
                let l:counts = ale#statusline#Count(l:bufnr)
                let l:num_errors = l:counts.error + l:counts.style_error
                let l:num_warnings = l:counts.total - l:num_errors
                if l:num_errors == 0 && l:num_warnings == 0
                    let l:ale_msg = ''
                else
                    let l:ale_msg = printf('%dW %dE', num_warnings, num_errors)
                endif
            endif
        endif
    endif
    return mellow_statusline#Part(l:ale_msg, a:color, a:lpad)
endfunction


function! mellow_statusline#WhitespaceCheck(color, lpad) abort
    " Mixed indent, bad expandtab or trailing spaces warning, see <https://github.com/millermedeiros/vim-statline>.
    if !exists('b:mellow_whitespace_warning')
        let l:warning = ''
        if &modifiable
            let l:tabs = search('^\t', 'nw') > 0
            let l:spaces = search('^ \+', 'nw') > 0
            if l:tabs && l:spaces
                let l:warning = 'mixed indent'
            elseif l:spaces && !&expandtab
                let l:warning = 'noexpandtab'
            elseif l:tabs && &expandtab
                let l:warning = 'expandtab'
            endif

            if search('\s\+$', 'nw') > 0
                if has('nvim')
                    let l:warning = strlen(l:warning) ? l:warning . ',trails' : 'trails'
                else
                    let l:warning = strlen(l:warning) ? l:warning . ',trails' : 'trails'
                endif
            endif
        endif
        let b:mellow_whitespace_warning = l:warning
    endif
    return mellow_statusline#Part(b:mellow_whitespace_warning, a:color, a:lpad)
endfunction


function! mellow_statusline#TabFile(flagcolor, tabpagenr) abort
    let l:tab = ''
    let l:buflist = tabpagebuflist(a:tabpagenr)
    for l:buf in l:buflist
        if getbufvar(l:buf, '&modifiable') && getbufvar(l:buf, '&modified')
            let l:tab .= a:flagcolor . ' + ' . '%*'
        endif
        if l:buf ==# tabpagewinnr(a:tabpagenr)
            l:name = getbufvar(l:buf, '&buftype') !=# ''
                        \ ? fnamemodify(bufname(l:buf), ':t')
                        \ : fnamemodify(bufname(l:buf), ':~:.')
            l:tab .= l:name
        endif
    endfor

    return l:tab
endfunction
