	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"qr.c"
	.global	__aeabi_d2iz
	.text
	.align	2
	.global	closest_perfect_square
	.type	closest_perfect_square, %function
closest_perfect_square:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	subs	r4, r2, #0
	beq	.L2
	bl	__aeabi_d2iz
	subs	r2, r0, #0
	movgt	r0, #1
	bgt	.L3
	b	.L2
.L5:
	mul	r3, r0, r0
	cmp	r3, r2
	bgt	.L4
.L3:
	add	r0, r0, #1
	sub	r3, r0, #1
	cmp	r3, r4
	bcc	.L5
.L4:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L2:
	mov	r0, #1
	b	.L4
	.size	closest_perfect_square, .-closest_perfect_square
	.global	__aeabi_dcmplt
	.align	2
	.global	abs_val
	.type	abs_val, %function
abs_val:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r2, #0
	mov	r3, #0
	mov	r6, r1
	mov	r5, r0
	bl	__aeabi_dcmplt
	cmp	r0, #0
	movne	r2, r5
	addne	r4, r6, #-2147483648
	movne	r3, r2
	movne	r6, r4
	movne	r5, r3
	mov	r4, r6
	mov	r0, r5
	mov	r1, r6
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
	.size	abs_val, .-abs_val
	.align	2
	.global	numt_copy_col
	.type	numt_copy_col, %function
numt_copy_col:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8}
	cmp	r0, #0
	mov	ip, r3
	ldr	r8, [sp, #20]
	beq	.L16
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r4, ip
	mov	r7, r1, asl #3
	mov	r6, r2, asl #3
	mov	r5, r3, asl #3
	mov	ip, #0
.L15:
	add	r3, r6, r4
	add	r0, r8, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	cmp	ip, r5
	stmia	r0, {r1-r2}
	add	r4, r4, r7
	bne	.L15
.L16:
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
	.size	numt_copy_col, .-numt_copy_col
	.align	2
	.global	numt_set_col
	.type	numt_set_col, %function
numt_set_col:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, r7}
	mov	r7, r3
	beq	.L21
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	ldr	r0, [sp, #16]
	mov	r6, r1, asl #3
	mov	r5, r2, asl #3
	mov	r4, r3, asl #3
	mov	ip, #0
.L20:
	add	r3, r7, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	add	r3, r5, r0
	cmp	ip, r4
	stmia	r3, {r1-r2}
	add	r0, r0, r6
	bne	.L20
.L21:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
	.size	numt_set_col, .-numt_set_col
	.align	2
	.global	mat_set_col
	.type	mat_set_col, %function
mat_set_col:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, r7}
	mov	r7, r3
	beq	.L26
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	ldr	r0, [sp, #16]
	mov	r6, r1, asl #3
	mov	r5, r2, asl #3
	mov	r4, r3, asl #3
	mov	ip, #0
.L25:
	add	r3, r7, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	add	r3, r5, r0
	cmp	ip, r4
	stmia	r3, {r1-r2}
	add	r0, r0, r6
	bne	.L25
.L26:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
	.size	mat_set_col, .-mat_set_col
	.global	__aeabi_dsub
	.align	2
	.global	vec_sub
	.type	vec_sub, %function
vec_sub:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r7, r1
	beq	.L31
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #13
	mov	r5, r2
	add	r6, r3, #8
	mov	r4, #0
.L30:
	add	r1, r7, r4
	ldmia	r1, {r2-r3}
	ldmia	r5, {r0-r1}
	bl	__aeabi_dsub
	add	r4, r4, #8
	cmp	r4, r6
	stmia	r5!, {r0-r1}
	bne	.L30
.L31:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	vec_sub, .-vec_sub
	.align	2
	.global	numt_vec_copy
	.type	numt_vec_copy, %function
numt_vec_copy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6}
	mov	r6, r1
	mov	r5, r2
	beq	.L36
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r4, r3, asl #3
	mov	ip, #0
.L35:
	add	r3, r6, ip
	add	r0, r5, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	cmp	ip, r4
	stmia	r0, {r1-r2}
	bne	.L35
.L36:
	ldmfd	sp!, {r4, r5, r6}
	bx	lr
	.size	numt_vec_copy, .-numt_vec_copy
	.align	2
	.global	vec_copy
	.type	vec_copy, %function
vec_copy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6}
	mov	r6, r1
	mov	r5, r2
	beq	.L41
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	add	r3, r3, #1
	mov	r4, r3, asl #3
	mov	ip, #0
.L40:
	add	r3, r6, ip
	add	r0, r5, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	cmp	ip, r4
	stmia	r0, {r1-r2}
	bne	.L40
.L41:
	ldmfd	sp!, {r4, r5, r6}
	bx	lr
	.size	vec_copy, .-vec_copy
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.align	2
	.global	vec_dot
	.type	vec_dot, %function
vec_dot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	sl, r1
	mov	r8, r2
	moveq	r5, #0
	moveq	r6, #0
	beq	.L45
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #13
	add	r7, r3, #8
	mov	r5, #0
	mov	r6, #0
	mov	r4, #0
.L46:
	add	ip, r8, r4
	add	r3, sl, r4
	ldmia	r3, {r0-r1}
	ldmia	ip, {r2-r3}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dadd
	add	r4, r4, #8
	cmp	r4, r7
	mov	r5, r0
	mov	r6, r1
	bne	.L46
.L45:
	mov	r0, r5
	mov	r1, r6
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
	.size	vec_dot, .-vec_dot
	.align	2
	.global	vec_mulc
	.type	vec_mulc, %function
vec_mulc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	subs	r8, r0, #0
	mov	r6, r2
	mov	r7, r3
	beq	.L52
	mov	r5, r1
	mov	r4, #0
.L51:
	ldmia	r5, {r0-r1}
	mov	r3, r7
	mov	r2, r6
	bl	__aeabi_dmul
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r8, r4
	stmia	r5!, {r0-r1}
	bhi	.L51
.L52:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	vec_mulc, .-vec_mulc
	.align	2
	.global	vec_mul
	.type	vec_mul, %function
vec_mul:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	cmp	r0, #0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r7, r1
	beq	.L57
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #13
	mov	r5, r2
	add	r6, r3, #8
	mov	r4, #0
.L56:
	add	r1, r7, r4
	ldmia	r1, {r2-r3}
	ldmia	r5, {r0-r1}
	bl	__aeabi_dmul
	add	r4, r4, #8
	cmp	r4, r6
	stmia	r5!, {r0-r1}
	bne	.L56
.L57:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	vec_mul, .-vec_mul
	.align	2
	.global	transpose_m
	.type	transpose_m, %function
transpose_m:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	cmp	r1, #0
	mov	r9, r0
	mov	r0, r3
	subne	r3, r9, #1
	movne	r3, r3, asl #16
	sub	sp, sp, #8
	movne	r3, r3, lsr #13
	str	r1, [sp, #4]
	str	r2, [sp, #0]
	movne	r6, r0
	addne	r8, r3, #8
	movne	fp, r9, asl #3
	movne	r7, r1, asl #3
	movne	sl, #0
	beq	.L64
.L61:
	cmp	r9, #0
	ldrne	r4, [sp, #0]
	movne	ip, #0
	movne	r5, sl, asl #3
	beq	.L63
.L62:
	add	r3, r5, r4
	add	r0, r6, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	cmp	ip, r8
	stmia	r0, {r1-r2}
	add	r4, r4, r7
	bne	.L62
.L63:
	add	sl, sl, #1
	ldr	r2, [sp, #4]
	mov	r3, sl, asl #16
	cmp	r2, r3, lsr #16
	add	r6, r6, fp
	bhi	.L61
.L64:
	add	sp, sp, #8
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	transpose_m, .-transpose_m
	.align	2
	.global	spec_map
	.type	spec_map, %function
spec_map:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	r0, r0, #100
	cmp	r0, #17
	ldrls	pc, [pc, r0, asl #2]
	b	.L67
.L72:
	.word	.L68
	.word	.L67
	.word	.L69
	.word	.L67
	.word	.L67
	.word	.L70
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L71
.L70:
	ldr	r0, .L74
.L67:
	bx	lr
.L71:
	ldr	r0, .L74+4
	bx	lr
.L69:
	ldr	r0, .L74+8
	bx	lr
.L68:
	ldr	r0, .L74+12
	bx	lr
.L75:
	.align	2
.L74:
	.word	.LC3
	.word	.LC2
	.word	.LC1
	.word	.LC0
	.size	spec_map, .-spec_map
	.align	2
	.global	zero_m
	.type	zero_m, %function
zero_m:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	subs	r9, r0, #0
	mov	r5, r1
	movne	r4, r2
	movne	sl, r1, asl #3
	movne	r8, #0
	movne	r6, #0
	movne	r7, #0
	beq	.L82
.L78:
	cmp	r5, #0
	movne	ip, #0
	beq	.L81
.L80:
	add	r1, ip, #1
	add	r3, ip, #2
	mov	r2, ip, asl #3
	mov	r3, r3, asl #16
	mov	r0, r1, asl #3
	add	r2, r4, r2
	cmp	r5, r1
	mov	ip, r3, lsr #16
	stmia	r2, {r6-r7}
	add	r3, r4, r0
	stmneia	r3, {r6-r7}
.L79:
	cmp	r5, ip
	bhi	.L80
.L81:
	add	r3, r8, #1
	mov	r3, r3, asl #16
	mov	r8, r3, lsr #16
	cmp	r9, r8
	add	r4, r4, sl
	bhi	.L78
.L82:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	bx	lr
	.size	zero_m, .-zero_m
	.global	__aeabi_dcmpgt
	.global	__aeabi_ddiv
	.align	2
	.global	vec_divc
	.type	vec_divc, %function
vec_divc:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r6, r2
	mov	r7, r3
	mov	r8, r0
	mov	r4, r1
	adr	r3, .L94
	ldmia	r3, {r2-r3}
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	beq	.L93
	cmp	r8, #0
	movne	r5, r4
	movne	r4, #0
	beq	.L90
.L89:
	ldmia	r5, {r0-r1}
	mov	r3, r7
	mov	r2, r6
	bl	__aeabi_ddiv
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r8, r4
	stmia	r5!, {r0-r1}
	bhi	.L89
.L90:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L93:
	ldr	r0, .L94+8
	ldr	r1, .L94+12
	mov	r2, #190
	ldr	r3, .L94+16
	bl	__assert_fail
.L95:
	.align	3
.L94:
	.word	-1629006314
	.word	1020396463
	.word	.LC4
	.word	.LC5
	.word	.LANCHOR0
	.size	vec_divc, .-vec_divc
	.global	__aeabi_i2d
	.global	__aeabi_dcmpge
	.align	2
	.global	sqr_rt
	.type	sqr_rt, %function
sqr_rt:
	@ Function supports interworking.
	@ args = 12, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	sub	sp, sp, #16
	stmia	sp, {r2-r3}
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	bl	__aeabi_d2iz
	subs	r1, r0, #0
	movge	r2, #46336
	ldr	r9, [sp, #56]
	addge	r2, r2, #5
	movge	r0, #1
	bge	.L99
	b	.L116
.L115:
	add	r0, r0, #1
	cmp	r0, r2
	beq	.L98
.L99:
	mul	r3, r0, r0
	cmp	r1, r3
	bge	.L115
.L98:
	cmp	r9, #0
	beq	.L100
	bl	__aeabi_i2d
	mov	sl, #0
	mov	r5, r0
	mov	r6, r1
	b	.L107
.L113:
	mov	r2, r5
	mov	r3, r6
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dmul
	add	r3, sp, #8
	ldmia	r3, {r2-r3}
	bl	__aeabi_dsub
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dsub
	mov	r2, r5
	mov	r3, r6
	mov	r7, r0
	mov	r8, r1
	bl	__aeabi_dsub
	mov	r2, #0
	mov	r3, #0
	mov	r6, r1
	mov	r5, r0
	bl	__aeabi_dcmplt
	cmp	r0, #0
	movne	r2, r5
	movne	r3, r2
	addne	r4, r6, #-2147483648
	movne	r5, r3
	movne	r6, r4
	mov	r2, r5
	mov	r3, r6
	add	r1, sp, #48
	ldmia	r1, {r0-r1}
	bl	__aeabi_dcmpge
	cmp	r0, #0
	bne	.L100
	add	sl, sl, #1
	cmp	r9, sl
	mov	r5, r7
	mov	r6, r8
	bls	.L100
.L107:
	mov	r2, r5
	mov	r3, r6
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dadd
	mov	r2, #0
	mov	r3, #0
	mov	r8, r1
	mov	r7, r0
	bl	__aeabi_dcmplt
	cmp	r0, #0
	moveq	r4, r8
	moveq	r2, r4
	addne	r2, r8, #-2147483648
	moveq	r3, r7
	movne	r3, r7
	mov	r1, r2
	mov	r2, r3
	mov	r3, r1
	ldmia	sp, {r0-r1}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	beq	.L113
	mov	r7, #0
	mov	r8, #0
.L100:
	mov	r0, r7
	mov	r1, r8
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L116:
	ldr	r0, .L117
	ldr	r1, .L117+4
	mov	r2, #73
	ldr	r3, .L117+8
	bl	__assert_fail
.L118:
	.align	2
.L117:
	.word	.LC6
	.word	.LC5
	.word	.LANCHOR0+12
	.size	sqr_rt, .-sqr_rt
	.align	2
	.global	l2_norm
	.type	l2_norm, %function
l2_norm:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	cmp	r0, #0
	sub	sp, sp, #16
	mov	r8, r1
	moveq	r5, #0
	moveq	r6, #0
	beq	.L121
	sub	r3, r0, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #13
	add	r7, r3, #8
	mov	r5, #0
	mov	r6, #0
	mov	r4, #0
.L122:
	add	r3, r8, r4
	ldmia	r3, {r0-r1}
	mov	r2, r0
	mov	r3, r1
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dadd
	add	r4, r4, #8
	cmp	r4, r7
	mov	r5, r0
	mov	r6, r1
	bne	.L122
.L121:
	mov	ip, #46336
	mov	r0, r5
	adr	r5, .L125
	ldmia	r5, {r4-r5}
	add	ip, ip, #4
	mov	r1, r6
	adr	r3, .L125+8
	ldmia	r3, {r2-r3}
	stmia	sp, {r4-r5}
	str	ip, [sp, #8]
	bl	sqr_rt
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L126:
	.align	3
.L125:
	.word	-2036257893
	.word	1023837339
	.word	-1629006314
	.word	1020396463
	.size	l2_norm, .-l2_norm
	.align	2
	.global	QR
	.type	QR, %function
QR:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, r1
	add	fp, sp, #32
	sub	sp, sp, #60
	mov	r9, r0
	str	r1, [fp, #-72]
	str	r2, [fp, #-76]
	str	r3, [fp, #-80]
	bcc	.L154
	mov	r0, r0, asl #3
	add	r3, r0, #14
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #3
	sub	sp, sp, r3
	mov	r1, sp
	sub	sp, sp, r3
	ldr	r3, [fp, #-72]
	mov	r2, r1, lsr #3
	mov	ip, sp
	cmp	r3, #0
	mov	r2, r2, asl #3
	mov	r3, ip, lsr #3
	str	r0, [fp, #-68]
	str	r2, [fp, #-84]
	mov	sl, r3, asl #3
	beq	.L143
	sub	r3, r9, #1
	mov	r3, r3, asl #16
	ldr	r0, [fp, #-72]
	mov	r3, r3, lsr #13
	ldr	r1, [fp, #4]
	mov	lr, #0
	add	r3, r3, #8
	mov	r0, r0, asl #3
	str	lr, [fp, #-56]
	str	r3, [fp, #-92]
	str	r0, [fp, #-64]
	str	r1, [fp, #-48]
	str	lr, [fp, #-52]
	mov	r2, lr
.L141:
	ldr	ip, [fp, #-52]
	ldr	r0, [fp, #-76]
	mov	r3, ip, asl #3
	mov	r2, r2, lsr #16
	cmp	r9, #0
	str	r2, [fp, #-40]
	add	lr, r0, r3
	beq	.L130
	mov	ip, #0
.L131:
	add	r3, lr, ip
	ldmia	r3, {r1-r2}
	ldr	r3, [fp, #-84]
	add	r0, r3, ip
	ldr	r3, [fp, #-92]
	add	ip, ip, #8
	cmp	ip, r3
	stmia	r0, {r1-r2}
	bne	.L131
.L130:
	ldr	ip, [fp, #-40]
	cmp	ip, #0
	ldreq	lr, [fp, #-56]
	moveq	lr, lr, asl #3
	streq	lr, [fp, #-88]
	beq	.L132
	ldr	r2, [fp, #-56]
	ldr	r0, [fp, #4]
	mov	r1, #0
	mov	r2, r2, asl #3
	str	r0, [fp, #-44]
	str	r1, [fp, #-60]
	str	r2, [fp, #-88]
.L138:
	cmp	r9, #0
	beq	.L133
	ldr	r3, [fp, #-60]
	ldr	ip, [fp, #-80]
	mov	r8, #0
	mov	lr, r3, asl #3
.L134:
	add	r3, lr, ip
	ldmia	r3, {r1-r2}
	add	r0, sl, r8
	ldr	r3, [fp, #-92]
	add	r8, r8, #8
	stmia	r0, {r1-r2}
	ldr	r0, [fp, #-64]
	cmp	r8, r3
	add	ip, ip, r0
	bne	.L134
	mov	r6, #0
	mov	r7, #0
	mov	r4, #0
.L135:
	ldr	r1, [fp, #-84]
	add	r3, sl, r4
	add	ip, r1, r4
	ldmia	r3, {r0-r1}
	ldmia	ip, {r2-r3}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dadd
	add	r4, r4, #8
	cmp	r8, r4
	mov	r6, r0
	mov	r7, r1
	bne	.L135
	ldr	r2, [fp, #-88]
	ldr	ip, [fp, #-44]
	add	r3, r2, ip
	stmia	r3, {r6-r7}
	mov	r5, sl
	mov	r4, #0
.L136:
	ldmia	r5, {r0-r1}
	mov	r3, r7
	mov	r2, r6
	bl	__aeabi_dmul
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r9, r4
	stmia	r5!, {r0-r1}
	bhi	.L136
	ldr	r5, [fp, #-84]
	mov	r4, #0
.L137:
	add	r1, sl, r4
	ldmia	r1, {r2-r3}
	ldmia	r5, {r0-r1}
	bl	__aeabi_dsub
	add	r4, r4, #8
	cmp	r8, r4
	stmia	r5!, {r0-r1}
	bne	.L137
.L142:
	ldr	lr, [fp, #-60]
	ldr	r1, [fp, #-44]
	add	lr, lr, #1
	ldr	r0, [fp, #-40]
	ldr	r2, [fp, #-64]
	mov	r3, lr, asl #16
	add	r1, r1, r2
	cmp	r0, r3, lsr #16
	str	lr, [fp, #-60]
	str	r1, [fp, #-44]
	bhi	.L138
.L132:
	mov	r0, r9
	ldr	r1, [fp, #-84]
	bl	l2_norm
	ldr	ip, [fp, #-88]
	ldr	lr, [fp, #-48]
	mov	r2, r0
	mov	r3, r1
	add	r1, ip, lr
	stmia	r1, {r2-r3}
	mov	r0, r9
	ldr	r1, [fp, #-84]
	bl	vec_divc
	cmp	r9, #0
	beq	.L139
	ldr	ip, [fp, #-80]
	mov	r0, #0
.L140:
	ldr	r1, [fp, #-84]
	add	r3, r1, r0
	ldmia	r3, {r1-r2}
	sub	r3, fp, #92
	ldmia	r3, {r3, lr}	@ phole ldm
	add	r0, r0, #8
	cmp	r0, r3
	add	r3, lr, ip
	stmia	r3, {r1-r2}
	ldr	r1, [fp, #-68]
	add	ip, ip, r1
	bne	.L140
.L139:
	sub	r2, fp, #56
	ldmia	r2, {r2, ip}	@ phole ldm
	add	r2, r2, #1
	ldr	lr, [fp, #-48]
	ldr	r3, [fp, #-72]
	ldr	r0, [fp, #-64]
	str	r2, [fp, #-56]
	mov	r2, r2, asl #16
	add	ip, ip, r9
	add	lr, lr, r0
	cmp	r3, r2, lsr #16
	str	ip, [fp, #-52]
	str	lr, [fp, #-48]
	bhi	.L141
.L143:
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L133:
	ldr	r1, [fp, #-88]
	ldr	r2, [fp, #-44]
	mov	r0, #0
	add	r3, r1, r2
	mov	r1, #0
	stmia	r3, {r0-r1}
	b	.L142
.L154:
	ldr	r0, .L155
	ldr	r1, .L155+4
	mov	r2, #44
	ldr	r3, .L155+8
	bl	__assert_fail
.L156:
	.align	2
.L155:
	.word	.LC7
	.word	.LC5
	.word	.LANCHOR0+20
	.size	QR, .-QR
	.align	2
	.global	openf
	.type	openf, %function
openf:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r4, r0
	bl	fopen
	subs	r5, r0, #0
	beq	.L160
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L160:
	ldr	r3, .L161
	mov	r2, r4
	ldr	r0, [r3, #0]
	ldr	r1, .L161+4
	bl	fprintf
	mov	r0, r5
	bl	exit
.L162:
	.align	2
.L161:
	.word	stderr
	.word	.LC8
	.size	openf, .-openf
	.align	2
	.global	printv
	.type	printv, %function
printv:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	subs	r6, r0, #0
	beq	.L166
	mov	r5, r1
	mov	r4, #0
.L165:
	ldmia	r5!, {r2-r3}
	ldr	r0, .L168
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r6, r4
	bhi	.L165
.L166:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L169:
	.align	2
.L168:
	.word	.LC0
	.size	printv, .-printv
	.align	2
	.global	printm
	.type	printm, %function
printm:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	fp, r1, #0
	mov	r7, r0
	mov	r6, r2
	movne	sl, r3
	movne	r9, r2, asl #3
	movne	r8, #0
	beq	.L175
.L172:
	cmp	r6, #0
	movne	r5, sl
	movne	r4, #0
	beq	.L174
.L173:
	ldmia	r5!, {r2-r3}
	ldr	r0, .L177
	bl	printf
	mov	r0, r7
	bl	printf
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r6, r4
	bhi	.L173
.L174:
	mov	r0, #10
	bl	putchar
	add	r3, r8, #1
	mov	r3, r3, asl #16
	mov	r8, r3, lsr #16
	cmp	fp, r8
	add	sl, sl, r9
	bhi	.L172
.L175:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L178:
	.align	2
.L177:
	.word	.LC0
	.size	printm, .-printm
	.align	2
	.global	fprintm
	.type	fprintm, %function
fprintm:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r8, r1
	sub	sp, sp, #12
	ldr	r1, .L186
	mov	r7, r3
	str	r2, [sp, #4]
	bl	openf
	ldr	r3, [sp, #4]
	cmp	r3, #0
	mov	r6, r0
	ldrne	r9, [sp, #48]
	movne	fp, r7, asl #3
	movne	sl, #0
	beq	.L180
.L181:
	cmp	r7, #0
	movne	r5, r9
	movne	r4, #0
	beq	.L183
.L182:
	ldmia	r5!, {r2-r3}
	ldr	r1, .L186+4
	mov	r0, r6
	bl	fprintf
	mov	r0, r6
	mov	r1, r8
	bl	fprintf
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r7, r4
	bhi	.L182
.L183:
	mov	r0, #10
	mov	r1, r6
	bl	fputc
	add	r3, sl, #1
	mov	r3, r3, asl #16
	mov	sl, r3, lsr #16
	ldr	r3, [sp, #4]
	cmp	r3, sl
	add	r9, r9, fp
	bhi	.L181
.L180:
	mov	r1, r6
	mov	r0, #10
	bl	fputc
	mov	r0, r6
	bl	fclose
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L187:
	.align	2
.L186:
	.word	.LC9
	.word	.LC0
	.size	fprintm, .-fprintm
	.align	2
	.global	fprintmt
	.type	fprintmt, %function
fprintmt:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r8, r1
	sub	sp, sp, #12
	ldr	r1, .L195
	mov	r7, r3
	str	r2, [sp, #4]
	bl	openf
	ldr	r3, [sp, #4]
	cmp	r3, #0
	mov	r6, r0
	ldrne	r9, [sp, #48]
	movne	fp, r7, asl #3
	movne	sl, #0
	beq	.L189
.L190:
	cmp	r7, #0
	movne	r5, r9
	movne	r4, #0
	beq	.L192
.L191:
	ldmia	r5!, {r2-r3}
	ldr	r1, .L195+4
	mov	r0, r6
	bl	fprintf
	mov	r0, r6
	mov	r1, r8
	bl	fprintf
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r7, r4
	bhi	.L191
.L192:
	mov	r0, #10
	mov	r1, r6
	bl	fputc
	add	r3, sl, #1
	mov	r3, r3, asl #16
	mov	sl, r3, lsr #16
	ldr	r3, [sp, #4]
	cmp	r3, sl
	add	r9, r9, fp
	bhi	.L190
.L189:
	mov	r1, r6
	mov	r0, #10
	bl	fputc
	mov	r0, r6
	bl	fclose
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L196:
	.align	2
.L195:
	.word	.LC9
	.word	.LC0
	.size	fprintmt, .-fprintmt
	.align	2
	.global	fscanm
	.type	fscanm, %function
fscanm:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #28
	mov	r7, r1
	ldr	r1, .L205
	str	r2, [fp, #-56]
	mov	r6, r3
	bl	openf
	ldr	r2, [fp, #-56]
	sub	sp, sp, #65536
	sub	sp, sp, #8
	cmp	r2, #0
	mov	r2, sp
	mov	r3, r2, lsr #3
	mov	r3, r3, asl #3
	str	r0, [fp, #-52]
	str	r3, [fp, #-60]
	beq	.L198
	mov	r3, r6, asl #3
	ldr	sl, [fp, #4]
	str	r3, [fp, #-48]
	mov	r8, #0
	sub	r9, fp, #40
.L201:
	mov	r1, #65536
	sub	r1, r1, #1
	ldr	r2, [fp, #-52]
	ldr	r0, [fp, #-60]
	bl	fgets
	ldr	r0, [fp, #-60]
	mov	r1, r7
	bl	strtok
	cmp	r6, #0
	beq	.L199
	mov	r5, sl
	mov	r4, #0
.L200:
	mov	r1, r9
	bl	strtod
	stmia	r5!, {r0-r1}
	mov	r0, #0
	mov	r1, r7
	bl	strtok
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r6, r4
	bhi	.L200
.L199:
	add	r3, r8, #1
	mov	r3, r3, asl #16
	ldr	r2, [fp, #-56]
	mov	r8, r3, lsr #16
	ldr	r3, [fp, #-48]
	cmp	r2, r8
	add	sl, sl, r3
	bhi	.L201
.L198:
	ldr	r0, [fp, #-52]
	bl	fclose
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L206:
	.align	2
.L205:
	.word	.LC10
	.size	fscanm, .-fscanm
	.global	__aeabi_i2f
	.global	__aeabi_fdiv
	.global	__aeabi_f2d
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, #5
	add	fp, sp, #32
	mov	r6, r1
	sub	sp, sp, #68
	mov	r1, #32	@ movhi
	strh	r1, [fp, #-38]	@ movhi
	bne	.L217
	ldmib	r6, {r3, r4}	@ phole ldm
	sub	r5, fp, #44
	mov	r2, #10
	ldr	r0, [r6, #12]
	mov	r1, r5
	str	r3, [fp, #-72]
	str	r4, [fp, #-68]
	bl	strtoull
	mov	r4, r0
	mov	r3, r4, asl #16
	mov	r2, #10
	mov	r1, r5
	ldr	r0, [r6, #16]
	mov	sl, r3, lsr #16
	bl	strtoull
	mov	r0, r0, asl #16
	mov	r9, r0, lsr #16
	mul	r3, sl, r9
	mul	r2, sl, sl
	mov	r3, r3, asl #3
	add	r3, r3, #8
	sub	sp, sp, r3
	mov	r2, r2, asl #3
	add	ip, sp, #8
	add	r2, r2, #8
	sub	sp, sp, r3
	add	r1, sp, #8
	sub	r4, r4, #1
	sub	sp, sp, r2
	add	r2, sp, #8
	mov	r4, r4, asl #16
	mov	r4, r4, lsr #13
	str	r1, [fp, #-84]
	str	r2, [fp, #-88]
	sub	sp, sp, r3
	mov	r1, #0
	mov	r2, #0
	str	ip, [fp, #-80]
	add	r8, r4, #8
	add	r3, sp, #8
	mov	r4, sl, asl #3
	mov	ip, #0
	str	r1, [fp, #-60]
	str	r2, [fp, #-56]
	str	r3, [fp, #-92]
	str	r4, [fp, #-48]
	str	ip, [fp, #-64]
	mov	r7, r9, asl #3
.L213:
	bl	clock
	mov	r1, r9
	str	r0, [fp, #-76]
	ldr	r2, [fp, #-80]
	mov	r0, sl
	bl	zero_m
	mov	r0, r9
	mov	r1, sl
	ldr	r2, [fp, #-84]
	bl	zero_m
	mov	r0, sl
	mov	r1, sl
	ldr	r2, [fp, #-88]
	bl	zero_m
	mov	r0, sl
	mov	r1, r9
	ldr	r2, [fp, #-92]
	bl	zero_m
	ldr	r4, [fp, #-80]
	ldr	r0, [fp, #-72]
	sub	r1, fp, #38
	mov	r2, sl
	mov	r3, r9
	str	r4, [sp, #0]
	bl	fscanm
	cmp	r9, #0
	ldrne	r4, [fp, #-84]
	movne	r6, #0
	beq	.L209
.L210:
	cmp	sl, #0
	ldrne	lr, [fp, #-80]
	movne	ip, #0
	movne	r5, r6, asl #3
	beq	.L212
.L211:
	add	r3, r5, lr
	add	r0, r4, ip
	ldmia	r3, {r1-r2}
	add	ip, ip, #8
	cmp	ip, r8
	stmia	r0, {r1-r2}
	add	lr, lr, r7
	bne	.L211
.L212:
	add	r6, r6, #1
	mov	r3, r6, asl #16
	ldr	ip, [fp, #-48]
	cmp	r9, r3, lsr #16
	add	r4, r4, ip
	bhi	.L210
.L209:
	ldr	r4, [fp, #-92]
	mov	r0, sl
	mov	r1, r9
	ldr	r2, [fp, #-84]
	ldr	r3, [fp, #-88]
	str	r4, [sp, #0]
	bl	QR
	ldr	ip, [fp, #-88]
	ldr	r0, [fp, #-68]
	sub	r1, fp, #38
	mov	r2, sl
	mov	r3, sl
	str	ip, [sp, #0]
	bl	fprintmt
	mov	r2, sl
	mov	r3, r9
	sub	r1, fp, #38
	ldr	r0, [fp, #-68]
	str	r4, [sp, #0]
	bl	fprintmt
	bl	clock
	ldr	r1, [fp, #-76]
	rsb	r0, r1, r0
	bl	__aeabi_i2f
	mov	r1, #1224736768
	add	r1, r1, #7602176
	add	r1, r1, #9216
	bl	__aeabi_fdiv
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	sub	r1, fp, #60
	ldmia	r1, {r0-r1}
	bl	__aeabi_dadd
	ldr	r2, [fp, #-64]
	add	r3, r2, #1
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	cmp	r3, #100
	str	r0, [fp, #-60]
	str	r1, [fp, #-56]
	str	r3, [fp, #-64]
	bne	.L213
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #5832704
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L218
	bl	printf
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L217:
	ldr	r0, .L218+4
	ldr	r1, .L218+8
	mov	r2, #15
	ldr	r3, .L218+12
	bl	__assert_fail
.L219:
	.align	2
.L218:
	.word	.LC13
	.word	.LC11
	.word	.LC12
	.word	.LANCHOR0+24
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__PRETTY_FUNCTION__.3123, %object
	.size	__PRETTY_FUNCTION__.3123, 9
__PRETTY_FUNCTION__.3123:
	.ascii	"vec_divc\000"
	.space	3
	.type	__PRETTY_FUNCTION__.2890, %object
	.size	__PRETTY_FUNCTION__.2890, 7
__PRETTY_FUNCTION__.2890:
	.ascii	"sqr_rt\000"
	.space	1
	.type	__PRETTY_FUNCTION__.2793, %object
	.size	__PRETTY_FUNCTION__.2793, 3
__PRETTY_FUNCTION__.2793:
	.ascii	"QR\000"
	.space	1
	.type	__PRETTY_FUNCTION__.3509, %object
	.size	__PRETTY_FUNCTION__.3509, 5
__PRETTY_FUNCTION__.3509:
	.ascii	"main\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%.8lf\000"
	.space	2
.LC1:
	.ascii	"%.8f\000"
	.space	3
.LC2:
	.ascii	"%u\000"
	.space	1
.LC3:
	.ascii	"%i\000"
	.space	1
.LC4:
	.ascii	"divisor > 1e-15\000"
.LC5:
	.ascii	"qr.h\000"
	.space	3
.LC6:
	.ascii	"(int)x >= 0\000"
.LC7:
	.ascii	"rows >= cols\000"
	.space	3
.LC8:
	.ascii	"FileError: cannot open %s\012\000"
	.space	1
.LC9:
	.ascii	"a\000"
	.space	2
.LC10:
	.ascii	"r\000"
	.space	2
.LC11:
	.ascii	"argc == 5\000"
	.space	2
.LC12:
	.ascii	"qr.c\000"
	.space	3
.LC13:
	.ascii	"Total time = %lf seconds\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
