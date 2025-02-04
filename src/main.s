.segment "HEADER"
  .byte "NES", $1A
  .byte 2, 1, 0, 0
  .byte 1, 0, 0, 0, 0, 0, 0, 0

.segment "CODE"
  .include "consts.inc"
  .include "utils/reset.inc"

  RESET:
  Init_NES

  ; Set background color
  LDA #$3F        ; PPU address high byte (palette location)
  STA $2006
  LDA #$00        ; PPU address low byte
  STA $2006
  LDA #$12        ; Red
  STA $2007

  LDA #NMI_BIT_SEQUENCE                         ; Enable NMI and set background to use the 2nd pattern table (at $1000)
  STA PPU_CTRL
  LDA #PPU_MASK_BIT_SEQUENCE
  STA PPU_MASK                                  ; Set PPU_MASK bits to render the background

  Forever:
  JMP Forever     ; Infinite loop

NMI:
  RTI             ; Return from NMI

IRQ:
  RTI

.segment "CHR1"
  .incbin "chars/mario.chr" ; Include CHR data (8 KB tile data)

.segment "CHR2"

.segment "VECTORS"
  .word NMI       ; NMI vector
  .word RESET     ; Reset vector
  .word IRQ       ; IRQ/BRK vector
