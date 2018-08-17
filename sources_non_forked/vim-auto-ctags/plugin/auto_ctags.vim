" Find source root

function! s:SetCtagsPath()
    " Set ctags path.
    if exists("b:vim_auto_ctags_root") && exists("b:vim_auto_ctags_tag_path")
        return
    endif
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

    if b:vim_auto_ctags_root == '/'
        " Not found.
        return
    endif

    let b:vim_auto_ctags_tag_path = simplify(b:vim_auto_ctags_root . '/.ctags')
    let &tags = b:vim_auto_ctags_tag_path
endfunction

function! s:UpdateCtags()
    " Update ctags.
    call s:SetCtagsPath()
    if !exists("b:vim_auto_ctags_root") || !exists("b:vim_auto_ctags_tag_path")
        return
    endif
    " Check if root directory is git root.
    if !isdirectory(b:vim_auto_ctags_root . '/.git')
        return
    endif
    " Generate ctags file
    if filereadable(b:vim_auto_ctags_tag_path)
        call system('ctags -a -o ' . b:vim_auto_ctags_tag_path . ' -R ' . expand('%:p'))
    else
        execute "silent !" . "echo 'Rebuilding ctags from " . b:vim_auto_ctags_root . "'"
        call system('ctags -o ' . b:vim_auto_ctags_tag_path . ' -R ' . b:vim_auto_ctags_root)
    endif
endfunction

" run on startup
call s:UpdateCtags()

" run on buffer write
autocmd BufWritePost * call s:UpdateCtags()
