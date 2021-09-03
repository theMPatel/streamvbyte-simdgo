// Code generated by command: go run asm.go -out ./encode_amd64.s. DO NOT EDIT.

#include "textflag.h"

DATA mask0101<>+0(SB)/2, $0x0101
GLOBL mask0101<>(SB), RODATA|NOPTR, $2

DATA mask7F00<>+0(SB)/2, $0x7f00
GLOBL mask7F00<>(SB), RODATA|NOPTR, $2

// func put8uint32Fast(in []uint32, outBytes []byte, shuffle *[256][16]uint8, lenTable *[256]uint8) (r uint16)
// Requires: AVX, AVX2
TEXT ·put8uint32Fast(SB), NOSPLIT, $0-66
	MOVQ         in_base+0(FP), AX
	VLDDQU       (AX), X0
	VLDDQU       16(AX), X1
	VPBROADCASTW mask0101<>+0(SB), X2
	VPBROADCASTW mask7F00<>+0(SB), X3
	VPMINUB      X2, X0, X4
	VPMINUB      X2, X1, X5
	VPACKUSWB    X5, X4, X4
	VPMINSW      X2, X4, X4
	VPADDUSW     X3, X4, X4
	VPMOVMSKB    X4, AX
	MOVW         AX, r+64(FP)
	MOVQ         shuffle+48(FP), CX
	MOVBQZX      AL, DX
	SHLQ         $0x04, DX
	ADDQ         CX, DX
	MOVWQZX      AX, BX
	SHRQ         $0x08, BX
	SHLQ         $0x04, BX
	ADDQ         CX, BX
	VPSHUFB      (DX), X0, X0
	VPSHUFB      (BX), X1, X1
	MOVQ         outBytes_base+24(FP), CX
	MOVQ         CX, DX
	MOVQ         lenTable+56(FP), BX
	MOVBQZX      AL, AX
	ADDQ         BX, AX
	MOVBQZX      (AX), AX
	ADDQ         AX, DX
	VMOVDQU      X0, (CX)
	VMOVDQU      X1, (DX)
	RET

// func put8uint32DeltaFast(in []uint32, outBytes []byte, prev uint32, shuffle *[256][16]uint8, lenTable *[256]uint8) (r uint16)
// Requires: AVX, AVX2
TEXT ·put8uint32DeltaFast(SB), NOSPLIT, $0-74
	MOVQ         in_base+0(FP), AX
	VLDDQU       (AX), X0
	VLDDQU       16(AX), X1
	VPALIGNR     $0x0c, X0, X1, X2
	VPSUBD       X2, X1, X1
	VBROADCASTSS prev+48(FP), X2
	VPALIGNR     $0x0c, X2, X0, X2
	VPSUBD       X2, X0, X0
	VPBROADCASTW mask0101<>+0(SB), X2
	VPBROADCASTW mask7F00<>+0(SB), X3
	VPMINUB      X2, X0, X4
	VPMINUB      X2, X1, X5
	VPACKUSWB    X5, X4, X4
	VPMINSW      X2, X4, X4
	VPADDUSW     X3, X4, X4
	VPMOVMSKB    X4, AX
	MOVW         AX, r+72(FP)
	MOVQ         shuffle+56(FP), CX
	MOVBQZX      AL, DX
	SHLQ         $0x04, DX
	ADDQ         CX, DX
	MOVWQZX      AX, BX
	SHRQ         $0x08, BX
	SHLQ         $0x04, BX
	ADDQ         CX, BX
	VPSHUFB      (DX), X0, X0
	VPSHUFB      (BX), X1, X1
	MOVQ         outBytes_base+24(FP), CX
	MOVQ         CX, DX
	MOVQ         lenTable+64(FP), BX
	MOVBQZX      AL, AX
	ADDQ         BX, AX
	MOVBQZX      (AX), AX
	ADDQ         AX, DX
	VMOVDQU      X0, (CX)
	VMOVDQU      X1, (DX)
	RET
