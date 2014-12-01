set nocompatible                " choose no compatibility with legacy vi
set showmode
set ruler
set mouse=a
colorscheme elflord
syntax enable
"" For regular expressions turn magic on
set magic
" Be smart when using tabs ;)
set smarttab
set autoindent                  " provide indentation
set smartindent
set relativenumber              " show relativenumber
set nofoldenable                 " disable folding
set confirm                       " prompt when existing from an unsaved file
set title                         " show file in titlebar
set cindent
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set nu                          " number of line
"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
"" Mapping
map! #2  :w              
map #5  :mak<CR>
map #8  :cn<CR>
map #7  :cp<CR>
:map #6 :!./a.out<CR>
"" Mark the cursor
set cursorline
set cursorcolumn
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"" Backup file
set backup
set writebackup
au BufWritePre * let &backupext = '%' . substitute(expand("%:p:h"), "/" , "%" , "g") . "%" . strftime("%Y.%m.%d.%H.%M.%S")
au VimLeave * !cp % ~/.vim_backups/$(echo %:p | sed 's/\(.*\/\)\(.*\)/\2\/\1/g' | sed 's/\//\%/g')$(date +\%Y.\%m.\%d.\%H.\%M.\%S).wq
set backupdir=~/.vim_backups/
" Auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc
"" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
fun! ViewUTF8()
  set encoding=utf-8
  set termencoding=big5
endfun
fun! UTF8()
  set encoding=utf-8
  set termencoding=big5
  set fileencoding=utf-8
  set fileencodings=ucs-bom,big5,utf-8,latin1
endfun
fun! Big5()
  set encoding=big5
  set fileencoding=big5
endfun
""Statusline
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? 
function! HighlightSearch()
    if &hls
   return 'H'
    else
   return ''
    endif
endfunction
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
