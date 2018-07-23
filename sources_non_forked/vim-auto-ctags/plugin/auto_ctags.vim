" Find source root
let b:ctag_root = fnamemodify('.', ':p')
if filereadable(b:ctag_root . '/CMakeLists.txt')
    while b:ctag_root != '/'
        if isdirectory(b:ctag_root . '/.git')
            let &path = &path . ',' . b:ctag_root
            let g:syntastic_cpp_include_dirs = [b:ctag_root]
            break
        endif
        let b:ctag_root = fnamemodify(b:ctag_root, ':h')
    endwhile
endif

" Set ctags path.
if b:ctag_root != '/'
    " Set ctags path
    let b:ctag_file = simplify(b:ctag_root . '/.ctags')
    let &tags = b:ctag_file
endif

function! s:UpdateCtags()
    " Update ctags.
    if b:ctag_root != '/'
        " Generate ctags file
        if filereadable(b:ctag_file)
            call system('ctags -a -o ' . b:ctag_file . ' -R ' . expand('%:p'))
        else
            execute "silent !" . "echo 'Rebuilding ctags from " . b:ctag_root . "'"
            call system('ctags -o ' . b:ctag_file . ' -R ' . b:ctag_root)
        endif
    endif
endfunction

" run on startup
call s:UpdateCtags()

" run on buffer write
autocmd BufWritePost * call s:UpdateCtags()
