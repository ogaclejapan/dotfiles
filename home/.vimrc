"__/__/__/__/__/__/__/__/__/__/
"__/ Dein Settings
"__/__/__/__/__/__/__/__/__/__/

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('itchyny/lightline.vim')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('vim-scripts/fish-syntax')
  call dein#add('kshenoy/vim-signature')
  call dein#add('osyo-manga/vim-over')
  call dein#add('jtratner/vim-flavored-markdown')
  call dein#add('itspriddle/vim-marked')
  call dein#add('rking/ag.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


"__/__/__/__/__/__/__/__/__/__/
"__/ Display Settings
"__/__/__/__/__/__/__/__/__/__/


"文字エンコード
set encoding=utf-8 nobomb

"行番号を表示
set number

"背景色(dark/light)
if has("gui_running")
  set background=light
  colorscheme solarized
ele
  set background=dark
  colorscheme Tomorrow-Night-Bright
end

"不可視文字を表示する
set list

"不可視文字のフォーマット
set listchars=tab:\ \ ,trail:-

"ステータスラインを常に表示する
set laststatus=2

"入力コマンドをステータスラインに表示
set showcmd

"モードをステータスラインに表示
set showmode

"1行が画面幅を超えても折り返さない
set nowrap

"__/__/__/__/__/__/__/__/__/__/
"__/ Search Settings
"__/__/__/__/__/__/__/__/__/__/

"検索条件の大文字小文字を区別しない
set ignorecase

"検索条件に大文字を含む場合のみ大文字小文字を区別する
set smartcase

"最後まで検索したら最初に戻る
set wrapscan

"検索結果をハイライト表示する
set nohlsearch

"__/__/__/__/__/__/__/__/__/__/
"__/ Basic Settings
"__/__/__/__/__/__/__/__/__/__/


"BSキーの挙動を他エディタと合わせる
set backspace=indent,eol,start

"タブインデントをスペースにする
set expandtab

"1タブあたりの表示スペース数
set tabstop=2

"自動インデント時のスペース数
set shiftwidth=2

"自動インデント
set smartindent

"改行時にインデントを現在行に合わせる
set autoindent

"最大履歴数
set history=1000

"ビープ音を鳴らさない
set visualbell

"外部からの変更時を自動リロードする
set autoread

"編集中のファイルから他ファイルに切替可能
set hidden

"クリップボードをWindowsと連携する
set clipboard=unnamed

"swapファイルは作成しない
set noswapfile

"backupファイルは作成しない
set nobackup
set nowb

"__/__/__/__/__/__/__/__/__/__/
"__/ Key Settings
"__/__/__/__/__/__/__/__/__/__/

"<Leader>のキーバインド
let mapleader=";"

"バッファ一覧を表示する
nnoremap <Leader><Leader> :<C-u>Unite buffer -buffer-name=file<CR>

"バッファを終了する
nnoremap <Leader>q :<C-u>bd<CR>

"ウィンドウを横２面に分割にする
nnoremap <Leader>h :<C-u>vsplit<CR>

"ウィンドウを縦２面に分割にする
nnoremap <Leader>v :<C-u>split<CR>

"ウィンドウに移動する
nnoremap <Leader><Left> <C-w>h
nnoremap <Leader><Down> <C-w>j
nnoremap <Leader><Up> <C-w>k
nnoremap <Leader><Right> <C-w>l

"次のウィンドウに移動する
nnoremap <Leader>o <C-w>w

"現在のウィンドウを最大化する
nnoremap <Leader>z <C-w>_<C-w>|

"現在のウィンドウ横幅を拡大する
nnoremap <Leader>> <C-w>>

"現在のウィンドウ横幅を縮小する
nnoremap <Leader>< <C-w><

"現在のウィンドウ縦幅を拡大する
nnoremap <Leader>+ <C-w>+

"現在のウィンドウ縦幅を縮小する
nnoremap <Leader>- <C-w>-

"現在のウィンドウを閉じる
nnoremap <Leader>x :<C-u>q<CR>

"タブを新規作成する
nnoremap <Leader>c :<C-u>tabnew<CR>

"次のタブに切り替える
nnoremap <Leader>n gt

"前のタブに切り替える
nnoremap <Leader>p gT

"タブの一覧を表示する
nnoremap <Leader>w :<C-u>Unite tab<CR>

"タブのバッファ一覧を表示する
nnoremap <Leader>t :<C-u>Unite buffer_tab -buffer-name=file<CR>

"サイドにファイルエクスプローラーを表示する
nnoremap <Leader>e :<C-u>VimFilerExplorer<CR>

"全面にファイルエクスプローラーを表示する
nnoremap <Leader>E :<C-u>VimFiler<CR>

"カレントディレクトリ配下をagでgrep検索する
nnoremap <Leader>g :<C-u>Ag

"カレントディレクトリ配下をagでファイル検索する
nnoremap <Leader>f :<C-u>AgFile

"全範囲を対象に任意の文字列を置換する
nnoremap <Leader>r :<C-u>OverCommandLine s/<CR>

"選択している範囲を対象に任意の文字列を置換する
vnoremap <Leader>r :OverCommandLine s/<CR>

"EasyMotionで表示エリア内2文字を検索して移動する
map <Leader>s <Plug>(easymotion-s2)

"EasyMotionでカーソル行から上部に行移動する
map <Leader>k <Plug>(easymotion-k)

"EasyMotionでカーソル行から下部に行移動する
map <Leader>j <Plug>(easymotion-j)

"EasyMotion within Line Motionでカーソル行１文字を検索して移動する
map <Leader>l <Plug>(easymotion-bd-fl)

"EasyMotionで検索する
nmap / <Plug>(easymotion-sn)
xmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-sn)
nmap n <Plug>(easymotion-next)
nmap N <Plug>(easymotion-prev)


"__/__/__/__/__/__/__/__/__/__/
"__/ Bundle Settings
"__/__/__/__/__/__/__/__/__/__/

"lightlineのカラースキーマを適用する(gvimのみ)
if has("gui_running")
  let g:lightline = { 'colorscheme' : 'solarized' }
endif

"lua対応vimならneocompleteを有効にする
if has('lua')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
end

"Unite grepをagに変更
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"Markdownの拡張子に対応する
augroup markdown
    autocmd!
    autocmd BufNewFile,BufRead *.{md,markdown} set filetype=ghmarkdown
augroup END

"EasyMotionのデフォルトマッピングを解除
let g:EasyMotion_do_mapping = 0

"EasyMotion検索で大文字が含まれる場合のみ大文字小文字を区別する
let g:EasyMotion_smartcase = 1

"Vimfilerの移動と連動してカレントディレクトリを変更する
let g:vimfiler_enable_auto_cd = 1
