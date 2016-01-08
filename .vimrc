syntax on "syntax highlight
set nocompatible "avoid the vim consistence/
set incsearch "match in searching
set nu "show the line number
set ignorecase smartcase "search is not case-sensitive
set autoindent                  "Preserve current indent on new lines
" set textwidth=100               "Wrap at this column
set backspace=indent,eol,start  "Make backspaces delete sensibly


set expandtab                   "Convert all tabs typed into spaces
set tabstop=4
set shiftwidth=4                "Indent/outdent by 4 columns
set shiftround                  "Indent/outdent to nearest tabstop
set history=100
set ruler "open the status bar
set hlsearch "search character highlight
set background=dark
""colorscheme solarized


if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif


" restore cursor position
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$") |  exe "normal! g`\"" | endif


" add shebang automatically
autocmd BufNewFile *.pl 0r ~/.vim/skeletons/skeleton.pl | :normal G
autocmd BufNewFile *.py 0r ~/.vim/skeletons/skeleton.py | :normal G
autocmd BufNewFile *.sh 0r ~/.vim/skeletons/skeleton.sh | :normal G


" php
autocmd BufNewFile *.php 0r ~/.vim/skeletons/skeleton.php | :normal G
" html
autocmd BufNewFile *.html 0r ~/.vim/skeletons/skeleton.html | :normal G
autocmd BufNewFile *.htm  0r ~/.vim/skeletons/skeleton.html | :normal G


" set executable permissions for sh/py/pl
au BufWritePost *.sh :!chmod a+x <afile>
au BufWritePost *.py :!chmod a+x <afile>
au BufWritePost *.pl :!chmod a+x <afile>


" When loading a file, if it reads in as Unix, but has a DOS line ending,
" and is not in binary mode, reload it in DOS format. Do this AFTER loading
" last known position to prevent always opening on last line.
"
" Time out the search after 1/10 second. Timeouts only available in 7.1.211
" and up, so just risk long loads in earlier versions.
if (v:version > 701 || v:version == 701 && has("patch211"))
  autocmd BufReadPost * nested
        \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc', 0, 100)) |
        \   let b:reload_dos = 1 |
        \   redir => s:num_dos_ends |
        \   silent %s#\r$##n |
        \   redir END |
        \   e ++ff=dos |
        \   echomsg "File has ".
        \     substitute(s:num_dos_ends, '^\_.\{-}\(\d\+\).*', '\1', '').
        \     " DOS-style line endings out of ".line('$')." lines." |
        \ endif
else
  autocmd BufReadPost * nested
        \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
        \   let b:reload_dos = 1 |
        \   e ++ff=dos |
        \ endif
endif
autocmd BufReadPost * if exists('b:reload_dos') | unlet b:reload_dos | endif


" gracefully paste
nnoremap <F2>: set invpaste paste?<Enter>
imap <F2> <C-O><F2>
set pastetoggle=<F2>


" highlight tailing white spaces
" set list listchars=trail:_
" highlight SpecialKey ctermfg=DarkGray ctermbg=yellow


set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" set fileencodings=utf-8


au FileType python set formatprg=/opt/bin/pyindent.py
noremap <F11> gggqG

" Set the vundle , which control the third part plug-in
set nocompatible " be iMproved
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!

Bundle 'gmarik/vundle'

" vim-scripts repos
Bundle 'AutoClose'
Bundle 'ZenCoding.vim'
Bundle 'ShowTrailingWhitespace'
Bundle 'FencView.vim'
Bundle 'pep8'
Bundle 'The-NERD-tree'

filetype plugin indent on " required!

autocmd FileType python setlocal et sta sw=2 sts=2
autocmd FileType ruby setlocal et sta sw=2 sts=2
autocmd FileType javascript setlocal et sta sw=2 sts=2
