" Find source root

function! s:SetCtagsPath()
    " Set ctags path.
    if !exists("b:vim_auto_ctags_root") || !exists("b:vim_auto_ctags_tag_path")
        let b:vim_auto_ctags_root = fnamemodify('.', ':p')
        if filereadable(b:vim_auto_ctags_root . '/CMakeLists.txt')
            while b:vim_auto_ctags_root != '/'
                if isdirectory(b:vim_auto_ctags_root . '/.git')
                    let &path = &path . ',' . b:vim_auto_ctags_root
                    let b:syntastic_cpp_include_dirs = [b:vim_auto_ctags_root]
                    break
                endif
                let b:vim_auto_ctags_root = fnamemodify(b:vim_auto_ctags_root, ':h')
            endwhile
        endif

        if b:vim_auto_ctags_root != '/'
            " Not found.
            let b:vim_auto_ctags_root = fnamemodify('.', ':p')
        endif

        let b:vim_auto_ctags_tag_path = simplify(b:vim_auto_ctags_root . '/.ctags')
        let &tags = b:vim_auto_ctags_tag_path
    endif
endfunction

function! s:UpdateCtags()
    " Update ctags.
    call s:SetCtagsPath()
    if b:vim_auto_ctags_root != '/' && filereadable(b:vim_auto_ctags_root . '/CMakeLists.txt')
        " Generate ctags file
        if filereadable(b:vim_auto_ctags_tag_path)
            call system('ctags -a -o ' . b:vim_auto_ctags_tag_path . ' -R ' . expand('%:p'))
        else
            execute "silent !" . "echo 'Rebuilding ctags from " . b:vim_auto_ctags_root . "'"
            call system('ctags -o ' . b:vim_auto_ctags_tag_path . ' -R ' . b:vim_auto_ctags_root)
        endif
    endif
endfunction

" run on startup
call s:UpdateCtags()

" run on buffer write
autocmd BufWritePost * call s:UpdateCtags()
