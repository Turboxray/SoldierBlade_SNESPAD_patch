SnesPad.READ_IO.pack.2buttonPCE:
    phx
    phy

    ;O Port. D0 drive the latch (SEL), D1 drives the clock (CLR).
    ;K Port: D0 = serial bit PAD 0. D1 = serial bit PAD 1. D2 = 1 and D3 = 1.

    ldx #15
    ldy #(S_LATCH_LO | CLOCK_HI)    ; Prep for loop

    lda #(S_LATCH_LO | CLOCK_HI)                
    sta jport               ; (CLR = 1, SEL = 1) set latch low for reset. Keep clock high
    nop

    lda #(S_LATCH_HI | CLOCK_HI)                
    sta jport               ; (CLR = 1, SEL = 1) set latch High to get sample inputs. Keep clock high
    nop

    lda #(S_LATCH_LO | CLOCK_HI)
    stz jport               ; (CLR = 1, SEL = 0) set latch low to lock input states. Keep clock high
    nop

.loop

                            ; #(S_LATCH_LO | CLOCK_LO)
    stz jport               ; (CLR = 0) clock low
    nop        
    lda jport               ; .. get data bits
    lsr a                   ;                   D7    D6     D5   D4  :  D3    D2   D1   D0      
    ror snes_pad_0_pack.1   ; SNES order is   Right, Left, Down,  Up  : Start, Sel,  Y,   B
    ror snes_pad_0_pack.0   ;                     _,    _,    _,   _  :    RS,  LS,  X,   A                
                            ; PCE order is:    Left, Down, Right, Up  :   Run,  Sel, II,  I


                            ; #(S_LATCH_LO | CLOCK_HI)
    sty jport               ; (CLR = 1) clock high

    dex
  bpl .loop

    lda snes_pad_0_pack.1
    lsr a
    and #$07
    eor #$07
    trb snes_pad_0_pack.0   ; side map RS->Select, LS->Y, X->B. A does nothing.

    lda snes_pad_0_pack.0
    tax
    and #$1f                ; Keep the lower bits, zero out in the upper bits (they'll be SET or left clear on the two operations below)
    sta snes_pad_0_pack.0
    txa
    asl a
    and #$C0                ; left/down
    tsb snes_pad_0_pack.0
    txa
    lsr a
    lsr a
    and #$20                ; right
    tsb snes_pad_0_pack.0

    ply
    plx
rts

SnesPad.GetSelectLow:
    lda snes_pad_0_pack.0
rts

SnesPad.GetSelectHigh:
    lda snes_pad_0_pack.0
    lsr a
    lsr a
    lsr a
    lsr a
rts

