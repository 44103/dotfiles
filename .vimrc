" 行数表示
set number
" シンタックスハイライト有効化
syntax enable
" ビープ音を消音
set belloff=all
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" タブサイズ変更・スペース
set expandtab
set tabstop=2
set shiftwidth=2
" 検索結果をハイライト
set hlsearch
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 対応する括弧を強調表示
set showmatch
" ヤンクでクリップボードにコピー
set clipboard^=unnamedplus
" UTF-8化
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 現在の行を強調表示
set cursorline
" smartindentの設定
set smartindent
" ステータスラインの有効化
set laststatus=2


" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
