// Code generated by command: go run asm.go -out ./decode_amd64.s. DO NOT EDIT.

#include "textflag.h"

// func get8uint32Fast(in []byte, out []uint32, shufA *[16]uint8, shufB *[16]uint8, lenA uint8)
// Requires: AVX
TEXT ·get8uint32Fast(SB), NOSPLIT, $0-72
	MOVQ    shufA+48(FP), AX
	MOVQ    shufB+56(FP), CX
	MOVQ    in_base+0(FP), DX
	MOVQ    DX, BX
	MOVBQZX lenA+64(FP), SI
	ADDQ    SI, BX
	VLDDQU  (DX), X0
	VLDDQU  (BX), X1
	VPSHUFB (AX), X0, X0
	VPSHUFB (CX), X1, X1
	MOVQ    out_base+24(FP), AX
	VMOVDQU X0, (AX)
	VMOVDQU X1, 16(AX)
	RET