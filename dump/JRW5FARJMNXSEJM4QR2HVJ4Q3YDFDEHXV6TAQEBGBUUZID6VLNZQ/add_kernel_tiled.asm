	.attribute	4, 16
	.attribute	5, "rv64i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zmmul1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.file	"LLVMDialectModule"
	.text
	.globl	add_kernel_tiled                # -- Begin function add_kernel_tiled
	.p2align	2
	.type	add_kernel_tiled,@function
add_kernel_tiled:                       # @add_kernel_tiled
.Lfunc_begin0:
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	.file	1 "/home/chlee/triton-cpu/python/tutorials" "01-vector-add.py"
	.loc	1 72 24 prologue_end            # 01-vector-add.py:72:24
	slliw	a4, a4, 12
	li	a5, 128
	.loc	1 73 22                         # 01-vector-add.py:73:22
	slli	a6, a4, 2
	add	a2, a2, a6
	add	a1, a1, a6
	add	a0, a0, a6
	li	a6, 32
	vsetvli	zero, a6, e32, m8, ta, ma
	vmv.v.i	v8, 0
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	.loc	1 74 48                         # 01-vector-add.py:74:48
	vsetvli	zero, zero, e32, m8, ta, mu
	vid.v	v16
	vor.vx	v24, v16, a4
	.loc	1 75 25                         # 01-vector-add.py:75:25
	vmslt.vx	v0, v24, a3
	.loc	1 76 20                         # 01-vector-add.py:76:20
	vmv8r.v	v24, v8
	.loc	1 77 20                         # 01-vector-add.py:77:20
	vmv8r.v	v16, v8
	.loc	1 76 20                         # 01-vector-add.py:76:20
	vle32.v	v24, (a0), v0.t
	.loc	1 77 20                         # 01-vector-add.py:77:20
	vle32.v	v16, (a1), v0.t
	.loc	1 78 21                         # 01-vector-add.py:78:21
	vadd.vv	v16, v16, v24
	.loc	1 79 39                         # 01-vector-add.py:79:39
	vse32.v	v16, (a2), v0.t
	.loc	1 73 22                         # 01-vector-add.py:73:22
	addi	a5, a5, -1
	addi	a0, a0, 128
	addi	a1, a1, 128
	addi	a2, a2, 128
	addi	a4, a4, 32
	bnez	a5, .LBB0_1
# %bb.2:
	.loc	1 73 4 is_stmt 0                # 01-vector-add.py:73:4
	ret
.Ltmp0:
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
