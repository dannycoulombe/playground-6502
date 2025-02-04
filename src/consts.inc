;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constants for PPU registers
;; https://www.nesdev.org/wiki/PPU_registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PPU_CTRL              = $2000                     ; VPHB SINN  - NMI enable (V), PPU master/slave (P), sprite height (H), background tile select (B), sprite tile select (S), increment mode (I), nametable select (NN)
PPU_MASK              = $2001
PPU_STATUS            = $2002
OAM_ADDR              = $2003
OAM_DATA              = $2004
PPU_SCROLL            = $2005
PPU_ADDR              = $2006
PPU_DATA              = $2007
PPU_OAM_DMA           = $4014


NMI_BIT_SEQUENCE      = %10010000
PPU_MASK_BIT_SEQUENCE = %00011110
