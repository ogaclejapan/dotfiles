"__/__/__/__/__/__/__/__/__/__/
"__/ NeoBundle Settings
"__/__/__/__/__/__/__/__/__/__/

" :NeoBundleInstall
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Install Bundle
NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/fish.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"__/__/__/__/__/__/__/__/__/__/
"__/ Display Settings
"__/__/__/__/__/__/__/__/__/__/

"コードのハイライト表示
syntax on

"文字エンコード
set encoding=utf-8 nobomb

"行番号を表示
set number

"背景色(dark/light)
if has("gui_running")
  set background=light
else
  set background=dark
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

"__/__/__/__/__/__/__/__/__/__/
"__/ Basic Settings
"__/__/__/__/__/__/__/__/__/__/

"<Leader>のキーバインド
let mapleader=","

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
"__/ Bundle Settings
"__/__/__/__/__/__/__/__/__/__/

if has("gui_running")
  let g:lightline = { 'colorscheme' : 'solarized' }
endif

