	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zmmul1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.file	"LLVMDialectModule"
	.text
	.globl	add_kernel_tiled                # -- Begin function add_kernel_tiled
	.p2align	2
	.type	add_kernel_tiled,@function
add_kernel_tiled:                       # @add_kernel_tiled
.Lfunc_begin0:
	.file	1 "/home/chlee/triton-cpu/python/tutorials" "01-vector-add.py"
	.loc	1 63 0                          # 01-vector-add.py:63:0
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	csrr	a5, vlenb
	li	a6, 18
	mul	a5, a5, a6
	sub	sp, sp, a5
	.cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x12, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 18 * vlenb
.Ltmp0:
	.loc	1 72 24 prologue_end            # 01-vector-add.py:72:24
	slli	a4, a4, 12
	li	a5, 128
	li	a6, 32
	li	a7, 4
	vsetvli	zero, a6, e32, m8, ta, ma
	vid.v	v8
	vsll.vi	v8, v8, 7
	addi	t0, sp, 16
	vs8r.v	v8, (t0)                        # vscale x 64-byte Folded Spill
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	.loc	1 0 24 is_stmt 0                # 01-vector-add.py:0:24
	addi	t0, sp, 16
	vl8r.v	v8, (t0)                        # vscale x 64-byte Folded Reload
	.loc	1 74 36 is_stmt 1               # 01-vector-add.py:74:36
	vsetvli	zero, a6, e32, m8, ta, ma
	vor.vx	v24, v8, a4
	vsetivli	zero, 16, e32, m4, ta, ma
	vmv.v.i	v4, 0
	csrr	t0, vlenb
	li	t1, 10
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vs4r.v	v4, (t0)                        # vscale x 32-byte Folded Spill
	csrr	t0, vlenb
	li	t1, 14
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vs4r.v	v4, (t0)                        # vscale x 32-byte Folded Spill
	.loc	1 75 25                         # 01-vector-add.py:75:25
	vsetvli	zero, a6, e32, m8, ta, ma
	vmslt.vx	v3, v24, a3
	csrr	t0, vlenb
	slli	t0, t0, 3
	add	t0, sp, t0
	addi	t0, t0, 16
	vs1r.v	v3, (t0)                        # vscale x 8-byte Folded Spill
	.loc	1 76 20                         # 01-vector-add.py:76:20
	vsetivli	zero, 16, e32, m8, ta, ma
	vslidedown.vi	v16, v24, 16
	vsetivli	zero, 16, e32, m4, ta, ma
	vwmulsu.vx	v8, v24, a7
	vsetivli	zero, 2, e8, mf4, ta, ma
	vslidedown.vi	v2, v3, 2
	csrr	t0, vlenb
	slli	t1, t0, 3
	add	t0, t1, t0
	add	t0, sp, t0
	addi	t0, t0, 16
	vs1r.v	v2, (t0)                        # vscale x 8-byte Folded Spill
	vsetivli	zero, 16, e32, m4, ta, mu
	vwmulsu.vx	v24, v16, a7
	vmv1r.v	v0, v2
	csrr	t0, vlenb
	li	t1, 10
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vl4r.v	v20, (t0)                       # vscale x 32-byte Folded Reload
	vluxei64.v	v20, (a0), v24, v0.t
	vmv1r.v	v0, v3
	csrr	t0, vlenb
	li	t1, 14
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vl4r.v	v16, (t0)                       # vscale x 32-byte Folded Reload
	vluxei64.v	v16, (a0), v8, v0.t
	csrr	t0, vlenb
	li	t1, 14
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vs4r.v	v16, (t0)                       # vscale x 32-byte Folded Spill
	.loc	1 77 20                         # 01-vector-add.py:77:20
	vmv1r.v	v0, v2
	vluxei64.v	v4, (a1), v24, v0.t
	vmv.v.i	v16, 0
	vmv1r.v	v0, v3
	vluxei64.v	v16, (a1), v8, v0.t
	csrr	t0, vlenb
	li	t1, 14
	mul	t0, t0, t1
	add	t0, sp, t0
	addi	t0, t0, 16
	vl4r.v	v0, (t0)                        # vscale x 32-byte Folded Reload
	.loc	1 83 39                         # 01-vector-add.py:83:39
	vadd.vv	v16, v16, v0
	csrr	t0, vlenb
	slli	t0, t0, 3
	add	t0, sp, t0
	addi	t0, t0, 16
	vl1r.v	v0, (t0)                        # vscale x 8-byte Folded Reload
	vsoxei64.v	v16, (a2), v8, v0.t
	vadd.vv	v8, v4, v20
	csrr	t0, vlenb
	slli	t1, t0, 3
	add	t0, t1, t0
	add	t0, sp, t0
	addi	t0, t0, 16
	vl1r.v	v0, (t0)                        # vscale x 8-byte Folded Reload
	vsoxei64.v	v8, (a2), v24, v0.t
	.loc	1 73 22                         # 01-vector-add.py:73:22
	addiw	a5, a5, -1
	addi	a4, a4, 1
	bnez	a5, .LBB0_1
# %bb.2:
	.loc	1 73 4 epilogue_begin is_stmt 0 # 01-vector-add.py:73:4
	csrr	a0, vlenb
	li	a1, 18
	mul	a0, a0, a1
	add	sp, sp, a0
	.cfi_def_cfa sp, 16
	addi	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
.Ltmp1:
.Lfunc_end0:
	.size	add_kernel_tiled, .Lfunc_end0-add_kernel_tiled
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	0                               # DW_CHILDREN_no
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.half	4                               # DWARF version number
	.word	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0x1f DW_TAG_compile_unit
	.word	.Linfo_string0                  # DW_AT_producer
	.half	2                               # DW_AT_language
	.word	.Linfo_string1                  # DW_AT_name
	.word	.Lline_table_start0             # DW_AT_stmt_list
	.word	.Linfo_string2                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.word	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"triton"                        # string offset=0
.Linfo_string1:
	.asciz	"01-vector-add.py"              # string offset=7
.Linfo_string2:
	.asciz	"/home/chlee/triton-cpu/python/tutorials" # string offset=24
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
