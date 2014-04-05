
;
; Keyremap settings for AutoHotkey
; @see http://www.autohotkey.com/
;
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
; Space( ␣ ) + SemiColon( ; ) to Code Completion for IDE
; ショートカット - コード補完
;
Space & `;::Send, {Blind}^{Space}

;
; Space( ␣ ) + G to Paste
; ショートカット - ペースト
;
Space & g::Send, {Blind}^v

;
; Space( ␣ ) + F to Copy
; ショートカット - コピー
;
Space & f::Send, {Blind}^c

;
; Space( ␣ ) + D to Cut
; ショートカット - カット
;
Space & d::Send, {Blind}^x

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
; Space( ␣ ) + Q to Quit
; ショートカット - 閉じる
;
Space & q::Send, {Blind}^w

;
; Space( ␣ ) + W to Whitespace Indent
; ショートカット - 半角スペース×2
;
Space & w::Send, {Space}{Space}

;
; Space( ␣ ) + E to Escape
; ショートカット - ESC
;
Space & e::Send, {Blind}{Esc}

;
; Space( ␣ ) + R to Reverse Switch Window
; ショートカット - ウィンドウ逆切り替え
;
Space & r::ShiftAltTab

;
; Space( ␣ ) + T to Switch Window
; ショートカット - ウィンドウ切り替え
; 
Space & t::AltTab

