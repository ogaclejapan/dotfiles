
LWin::LCtrl
Space::Send, {Blind}{Space}

;
; Space( ␣ ) + H | J | K | L to Left/Down/Up/Right
; カーソルを移動 - 上下左右
;
Space & h::Send, {Blind}{Left}
Space & j::Send, {Blind}{Down}
Space & k::Send, {Blind}{Up}
Space & l::Send, {Blind}{Right}

;
; Space( ␣ ) + P | Slash( / ) to PageUp/PageDown
; カーソルを移動 - ページ上下
;
Space & p::Send, {PgUp}
Space & /::Send, {PgDn}

;
; Space( ␣ ) + U | N to Document Head/Tail
; カーソルを移動 - 先頭／末尾
;
Space & ,::Send, {Blind}{Home}
Space & .::Send, {Blind}{End}

;
; Space( ␣ ) + Dot( . ) | Comma( , ) to Line Head/Tail
; カーソルを移動 - 行頭／行末
;
Space & u::Send, {Blind}^{Home}
Space & n::Send, {Blind}^{End}

;
; Space( ␣ ) + I | O to Word Prev/Next
; カーソルを移動 - 前の単語／次の単語
;
Space & i::Send, {Blind}^{Left}
Space & o::Send, {Blind}^{Right}

;
; Space( ␣ ) + 1..9 | 0 | Minus( - ) | Equal( = ) to F1..F12
; ショートカット - F1〜F12補完
;
Space & 1::Send, {Blind}{F1}
Space & 2::Send, {Blind}{F2}
Space & 3::Send, {Blind}{F3}
Space & 4::Send, {Blind}{F4}
Space & 5::Send, {Blind}{F5}
Space & 6::Send, {Blind}{F6}
Space & 7::Send, {Blind}{F7}
Space & 8::Send, {Blind}{F8}
Space & 9::Send, {Blind}{F9}
Space & 0::Send, {Blind}{F10}
Space & -::Send, {Blind}{F11}
Space & =::Send, {Blind}{F12}

;
; Space( ␣ ) + M to Change Input Method
; ショートカット - IME入力切替
;
Space & m::Send, {vkF3sc029}

;
; Space( ␣ ) + V to Paste
; ショートカット - 貼り付け
;
Space & v::Send, {Blind}^v

;
; Space( ␣ ) + C to Copy
; ショートカット - コピー
;
Space & c::Send, {Blind}^c

;
; Space( ␣ ) + X to Cut
; ショートカット - 切り取り
;
Space & x::Send, {Blind}^x

;
; Space( ␣ ) + Z to Undo
; ショートカット - 取り消す
;
Space & z::Send, {Blind}^z

;
; Space( ␣ ) + F to Find
; ショートカット - 検索
;
Space & f::Send, {Blind}^f

;
; Space( ␣ ) + S to Save
; ショートカット - 保存
;
Space & s::Send, {Blind}^s

;
; Space( ␣ ) + A to SelectAll
; ショートカット - 全選択
;
Space & a::Send, {Blind}^a

;
; Space( ␣ ) + T to Switch Window
; ショートカット - ウィンドウ切り替え
; 
Space & t::AltTab

;
; Space( ␣ ) + R to Reverse Switch Window
; ショートカット - ウィンドウ逆切り替え
;
Space & r::ShiftAltTab

;
; Space( ␣ ) + E to Escape
; ショートカット - ESC
;
Space & e::Send, {Blind}{Esc}


#IfWinActive ahk_class mintty

;
; Space( ␣ ) + SemiColon( ; ) to Prefix key for tmux
; アプリケーション(tmuxのみ) - プレフィックスキー(Ctrl+b)
;
Space & `;::Send, {Blind}^b

#IfWinActive

#IfWinNotActive ahk_class mintty

;
; Space( ␣ ) + SemiColon( ; ) to Code Completion for IDE
; アプリケーション(tmux以外) - コード補完(Ctrl+Space)
;
Space & `;::Send, {Blind}^{Space}

#IfWinNotActive
