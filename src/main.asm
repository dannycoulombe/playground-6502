; ca65-compatible NES program to display a single sprite

        .segment "HEADER"
        .byte "NES", $1A      ; NES file header
        .byte 1, 1, 0, 0      ; 1 PRG bank, 1 CHR bank, no mapper or flags
        .byte 0, 0, 0, 0, 0, 0, 0, 0

        .segment "VECTORS"
        .word NMI             ; NMI vector
        .word RESET           ; Reset vector
        .word 0               ; IRQ/BRK vector

        .segment "CODE"
RESET:
        SEI                   ; Disable interrupts
        CLD                   ; Clear decimal mode
        LDX #$FF              ; Set stack pointer
        TXS
        INX                   ; Clear X register
        STX $2000             ; Disable NMI and rendering
        STX $2001
        STX $4010             ; Disable DMC DMA

        ; Wait for VBlank
WaitVBlank:
        BIT $2002
        BPL WaitVBlank

; Set background color
    LDA #$3F          ; PPU address high byte (palette location)
    STA $2006
    LDA #$00          ; PPU address low byte
    STA $2006
    LDA #$21          ; Color value (e.g., light gray)
    STA $2007

        ; Set sprite data into OAM
        LDA #$80              ; Y position
        STA $0200             ; OAM[0]
        LDA #$02              ; Tile index (from CHR ROM)
        STA $0201             ; OAM[1]
        LDA #$00              ; Attributes (no flip, palette 0)
        STA $0202             ; OAM[2]
        LDA #$80              ; X position
        STA $0203             ; OAM[3]

        ; Enable NMI and sprites
        LDA #%10000000        ; Enable NMI
        STA $2000
        LDA #%00010000        ; Enable sprites only
        STA $2001

Forever:
        JMP Forever           ; Infinite loop

NMI:
        RTI                   ; Return from NMI

        .segment "CHARS"
        .incbin "chars/mario.chr" ; Include CHR data (8 KB tile data)