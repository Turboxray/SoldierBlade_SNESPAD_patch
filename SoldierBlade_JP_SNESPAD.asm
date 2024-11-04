     ; Include the Rom to overwrite

    .include "incbin.asm"    ; Must be US or JP headerless rom. If using the US version, it MUST be in normal bit format (not that "swapped bits" dump nonsense)

jport      = $1000
S_LATCH_HI = $01                ; SEL (D0)
S_LATCH_LO = $00
CLOCK_HI   = $02                ; CLR (D1)
CLOCK_LO   = $00


    ; We going to use the very end of the stack for variables.
snes_pad_0_pack.0 = $2100
snes_pad_0_pack.1 = $2101



        ; Set the bank and org to overwrite
 .bank $00
 .org $FF62

  .include "core.asm"

    ; Replaced code for all "LDA $1000"

 .org $e57f
    jsr SnesPad.GetSelectHigh

.org $e58f
    jsr SnesPad.GetSelectLow


    ;  The last "STA $1000" setup in the game before the "reads"
.org $e573
    jsr SnesPad.READ_IO.pack.2buttonPCE

.org $e568
    nop
    nop
    nop

.org $e56d
    nop
    nop
    nop

.org $e589
    nop
    nop
    nop

