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
	subs	r1, r0, #0
	ble	.L2
	cmp	r1, #3
	movle	r0, #2
	movgt	r0, #2
	bgt	.L5
	b	.L4
.L6:
	mul	r3, r0, r0
	cmp	r3, r1
	bgt	.L4
	add	r0, r2, #2
	mul	r3, r0, r0
	cmp	r3, r1
	bgt	.L4
.L5:
	cmp	r4, r0
	mov	r2, r0
	add	r0, r0, #1
	bhi	.L6
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	subs	sl, r0, #0
	mov	r9, r3
	ldr	fp, [sp, #32]
	beq	.L18
	mov	r8, r1, asl #3
	mov	r7, r2, asl #3
	mov	r0, #0
.L17:
	mla	r3, r8, r0, r9
	add	r3, r3, r7
	add	ip, r0, #1
	add	r2, r0, #2
	ldmia	r3, {r4-r5}
	mov	r3, r0, asl #3
	mov	r2, r2, asl #16
	mov	r1, ip, asl #3
	add	r3, fp, r3
	cmp	ip, sl
	mov	r0, r2, lsr #16
	add	r6, fp, r1
	stmia	r3, {r4-r5}
	mlane	r3, r8, ip, r9
	addne	r3, r3, r7
	ldmneia	r3, {r1-r2}
	stmneia	r6, {r1-r2}
.L16:
	cmp	sl, r0
	bhi	.L17
.L18:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	subs	sl, r0, #0
	mov	r7, r3
	ldr	r9, [sp, #28]
	beq	.L24
	mov	r8, r1, asl #3
	mov	r6, r2, asl #3
	mov	r0, #0
.L23:
	mla	r1, r8, r0, r9
	mov	r3, r0, asl #3
	add	r3, r7, r3
	add	ip, r0, #1
	add	r2, r0, #2
	ldmia	r3, {r4-r5}
	mov	r2, r2, asl #16
	mov	r3, ip, asl #3
	add	r1, r1, r6
	cmp	ip, sl
	mov	r0, r2, lsr #16
	stmia	r1, {r4-r5}
	add	r2, r7, r3
	mlane	r3, r8, ip, r9
	ldmneia	r2, {r1-r2}
	addne	r3, r3, r6
	stmneia	r3, {r1-r2}
.L22:
	cmp	sl, r0
	bhi	.L23
.L24:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	subs	sl, r0, #0
	mov	r7, r3
	ldr	r9, [sp, #28]
	beq	.L30
	mov	r8, r1, asl #3
	mov	r6, r2, asl #3
	mov	r0, #0
.L29:
	mla	r1, r8, r0, r9
	mov	r3, r0, asl #3
	add	r3, r7, r3
	add	ip, r0, #1
	add	r2, r0, #2
	ldmia	r3, {r4-r5}
	mov	r2, r2, asl #16
	mov	r3, ip, asl #3
	add	r1, r1, r6
	cmp	ip, sl
	mov	r0, r2, lsr #16
	stmia	r1, {r4-r5}
	add	r2, r7, r3
	mlane	r3, r8, ip, r9
	ldmneia	r2, {r1-r2}
	addne	r3, r3, r6
	stmneia	r3, {r1-r2}
.L28:
	cmp	sl, r0
	bhi	.L29
.L30:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	subs	sl, r0, #0
	mov	r8, r1
	mov	r7, r2
	beq	.L36
	mov	r5, #0
.L35:
	mov	r4, r5, asl #3
	add	r1, r8, r4
	add	r4, r7, r4
	ldmia	r1, {r2-r3}
	ldmia	r4, {r0-r1}
	bl	__aeabi_dsub
	add	r2, r5, #1
	mov	r3, r2, asl #3
	cmp	r2, sl
	add	ip, r8, r3
	add	r6, r7, r3
	stmia	r4, {r0-r1}
	beq	.L34
	ldmia	ip, {r2-r3}
	ldmia	r6, {r0-r1}
	bl	__aeabi_dsub
	stmia	r6, {r0-r1}
.L34:
	add	r3, r5, #2
	mov	r3, r3, asl #16
	mov	r5, r3, lsr #16
	cmp	sl, r5
	bhi	.L35
.L36:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	subs	sl, r0, #0
	mov	r8, r1
	mov	r7, r2
	beq	.L42
	mov	ip, #0
.L41:
	mov	r1, ip, asl #3
	add	r3, r8, r1
	add	r0, ip, #1
	add	r2, ip, #2
	ldmia	r3, {r4-r5}
	mov	r2, r2, asl #16
	mov	r3, r0, asl #3
	add	r1, r7, r1
	cmp	r0, sl
	mov	ip, r2, lsr #16
	add	r6, r8, r3
	add	r2, r7, r3
	stmia	r1, {r4-r5}
	ldmneia	r6, {r3-r4}
	stmneia	r2, {r3-r4}
.L40:
	cmp	sl, ip
	bhi	.L41
.L42:
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	subs	sl, r0, #0
	mov	r8, r1
	mov	r7, r2
	beq	.L48
	mov	ip, #0
.L47:
	mov	r1, ip, asl #3
	add	r3, r8, r1
	add	r0, ip, #1
	add	r2, ip, #2
	ldmia	r3, {r4-r5}
	mov	r2, r2, asl #16
	mov	r3, r0, asl #3
	add	r1, r7, r1
	cmp	r0, sl
	mov	ip, r2, lsr #16
	add	r6, r8, r3
	add	r2, r7, r3
	stmia	r1, {r4-r5}
	ldmneia	r6, {r3-r4}
	stmneia	r2, {r3-r4}
.L46:
	cmp	sl, ip
	bhi	.L47
.L48:
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	subs	sl, r0, #0
	mov	r8, r1
	mov	r7, r2
	moveq	r4, #0
	moveq	r5, #0
	beq	.L52
	mov	r4, #0
	mov	r5, #0
	mov	r6, #0
.L54:
	mov	r3, r6, asl #3
	add	ip, r7, r3
	add	r3, r8, r3
	ldmia	r3, {r0-r1}
	ldmia	ip, {r2-r3}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r2, r6, #1
	mov	r3, r2, asl #3
	cmp	r2, sl
	mov	r4, r0
	mov	r5, r1
	add	ip, r7, r3
	add	r0, r8, r3
	beq	.L53
	ldmia	ip, {r2-r3}
	ldmia	r0, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	mov	r4, r0
	mov	r5, r1
.L53:
	add	r3, r6, #2
	mov	r3, r3, asl #16
	mov	r6, r3, lsr #16
	cmp	sl, r6
	bhi	.L54
.L52:
	mov	r0, r4
	mov	r1, r5
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
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	fp, r0, #0
	mov	sl, r1
	mov	r8, r2
	mov	r9, r3
	beq	.L61
	mov	r6, #0
.L60:
	mov	r4, r6, asl #3
	add	r4, sl, r4
	ldmia	r4, {r0-r1}
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_dmul
	add	r5, r6, #1
	mov	ip, r5, asl #3
	cmp	r5, fp
	mov	r2, r8
	mov	r3, r9
	add	r7, sl, ip
	stmia	r4, {r0-r1}
	beq	.L59
	ldmia	r7, {r0-r1}
	bl	__aeabi_dmul
	stmia	r7, {r0-r1}
.L59:
	add	r3, r6, #2
	mov	r3, r3, asl #16
	mov	r6, r3, lsr #16
	cmp	fp, r6
	bhi	.L60
.L61:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	vec_mulc, .-vec_mulc
	.align	2
	.global	vec_mul
	.type	vec_mul, %function
vec_mul:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	subs	sl, r0, #0
	mov	r8, r1
	mov	r7, r2
	beq	.L67
	mov	r5, #0
.L66:
	mov	r4, r5, asl #3
	add	r1, r8, r4
	add	r4, r7, r4
	ldmia	r1, {r2-r3}
	ldmia	r4, {r0-r1}
	bl	__aeabi_dmul
	add	r2, r5, #1
	mov	r3, r2, asl #3
	cmp	r2, sl
	add	ip, r8, r3
	add	r6, r7, r3
	stmia	r4, {r0-r1}
	beq	.L65
	ldmia	ip, {r2-r3}
	ldmia	r6, {r0-r1}
	bl	__aeabi_dmul
	stmia	r6, {r0-r1}
.L65:
	add	r3, r5, #2
	mov	r3, r3, asl #16
	mov	r5, r3, lsr #16
	cmp	sl, r5
	bhi	.L66
.L67:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
	.size	vec_mul, .-vec_mul
	.align	2
	.global	transpose_m
	.type	transpose_m, %function
transpose_m:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	cmp	r1, #0
	sub	sp, sp, #16
	str	r1, [sp, #4]
	mov	r8, r0
	mov	fp, r2
	beq	.L75
	mov	r7, r3
	mov	r2, r0, asl #3
	mov	r3, #0
	str	r2, [sp, #12]
	str	r3, [sp, #8]
	mov	r9, r1, asl #3
.L71:
	cmp	r8, #0
	ldrne	r2, [sp, #8]
	movne	r0, #0
	movne	sl, r2, asl #3
	beq	.L74
.L73:
	mla	r3, r9, r0, fp
	add	r3, r3, sl
	add	ip, r0, #1
	add	r2, r0, #2
	ldmia	r3, {r4-r5}
	mov	r3, r0, asl #3
	mov	r2, r2, asl #16
	mov	r1, ip, asl #3
	add	r3, r7, r3
	cmp	ip, r8
	mov	r0, r2, lsr #16
	add	r6, r7, r1
	stmia	r3, {r4-r5}
	mlane	r3, r9, ip, fp
	addne	r3, r3, sl
	ldmneia	r3, {r1-r2}
	stmneia	r6, {r1-r2}
.L72:
	cmp	r8, r0
	bhi	.L73
.L74:
	ldr	r2, [sp, #8]
	add	r2, r2, #1
	mov	r3, r2, asl #16
	str	r2, [sp, #8]
	ldr	r2, [sp, #4]
	cmp	r2, r3, lsr #16
	ldr	r3, [sp, #12]
	add	r7, r7, r3
	bhi	.L71
.L75:
	add	sp, sp, #16
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
	b	.L78
.L83:
	.word	.L79
	.word	.L78
	.word	.L80
	.word	.L78
	.word	.L78
	.word	.L81
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L78
	.word	.L82
.L81:
	ldr	r0, .L85
.L78:
	bx	lr
.L82:
	ldr	r0, .L85+4
	bx	lr
.L80:
	ldr	r0, .L85+8
	bx	lr
.L79:
	ldr	r0, .L85+12
	bx	lr
.L86:
	.align	2
.L85:
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
	beq	.L93
.L89:
	cmp	r5, #0
	movne	ip, #0
	beq	.L92
.L91:
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
.L90:
	cmp	r5, ip
	bhi	.L91
.L92:
	add	r3, r8, #1
	mov	r3, r3, asl #16
	mov	r8, r3, lsr #16
	cmp	r9, r8
	add	r4, r4, sl
	bhi	.L89
.L93:
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r2
	mov	r5, r3
	mov	r8, r0
	mov	sl, r1
	adr	r3, .L103
	ldmia	r3, {r2-r3}
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	beq	.L102
	mov	r1, #1069547520
	mov	r2, r4
	mov	r3, r5
	mov	r0, #0
	add	r1, r1, #3145728
	bl	__aeabi_ddiv
	cmp	r8, #0
	mov	r6, r0
	mov	r7, r1
	beq	.L100
	mov	r5, #0
.L99:
	mov	r4, r5, asl #3
	add	r4, sl, r4
	ldmia	r4, {r0-r1}
	mov	r3, r7
	mov	r2, r6
	bl	__aeabi_dmul
	add	r3, r5, #1
	cmp	r3, r8
	stmia	r4, {r0-r1}
	beq	.L98
	mov	r4, r3, asl #3
	add	r4, sl, r4
	ldmia	r4, {r0-r1}
	mov	r2, r6
	mov	r3, r7
	bl	__aeabi_dmul
	stmia	r4, {r0-r1}
.L98:
	add	r3, r5, #2
	mov	r3, r3, asl #16
	mov	r5, r3, lsr #16
	cmp	r8, r5
	bhi	.L99
.L100:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L102:
	ldr	r0, .L103+8
	ldr	r1, .L103+12
	mov	r2, #243
	ldr	r3, .L103+16
	bl	__assert_fail
.L104:
	.align	3
.L103:
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
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	stmia	sp, {r2-r3}
	bl	__aeabi_d2iz
	subs	ip, r0, #0
	movge	r1, #46336
	ldr	r9, [sp, #56]
	addge	r1, r1, #5
	movge	r0, #1
	bge	.L108
	b	.L125
.L124:
	mov	r2, r0
	add	r0, r0, #1
	mul	r3, r0, r0
	cmp	ip, r3
	blt	.L107
	add	r0, r2, #2
	cmp	r0, r1
	beq	.L107
.L108:
	mul	r3, r0, r0
	cmp	ip, r3
	bge	.L124
.L107:
	cmp	r9, #0
	beq	.L109
	bl	__aeabi_i2d
	mov	sl, #0
	mov	r5, r0
	mov	r6, r1
	b	.L116
.L122:
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
	bne	.L109
	add	sl, sl, #1
	cmp	r9, sl
	mov	r5, r7
	mov	r6, r8
	bls	.L109
.L116:
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
	beq	.L122
	mov	r7, #0
	mov	r8, #0
.L109:
	mov	r0, r7
	mov	r1, r8
	add	sp, sp, #16
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L125:
	ldr	r0, .L126
	ldr	r1, .L126+4
	mov	r2, #73
	ldr	r3, .L126+8
	bl	__assert_fail
.L127:
	.align	2
.L126:
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
	stmfd	sp!, {r4, r5, lr}
	mov	r2, r1
	sub	sp, sp, #20
	bl	vec_dot
	adr	r5, .L130
	ldmia	r5, {r4-r5}
	mov	ip, #46336
	add	ip, ip, #4
	adr	r3, .L130+8
	ldmia	r3, {r2-r3}
	stmia	sp, {r4-r5}
	str	ip, [sp, #8]
	bl	sqr_rt
	add	sp, sp, #20
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L131:
	.align	3
.L130:
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
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, r1
	add	fp, sp, #32
	sub	sp, sp, #44
	mov	r6, r0
	str	r1, [fp, #-56]
	str	r2, [fp, #-60]
	str	r3, [fp, #-64]
	bcc	.L142
	mov	r3, r0, asl #3
	add	r3, r3, #14
	mov	r3, r3, lsr #3
	mov	r3, r3, asl #3
	ldr	r0, [fp, #-56]
	sub	sp, sp, r3
	add	sl, sp, #8
	cmp	r0, #0
	sub	sp, sp, r3
	add	r7, sp, #8
	beq	.L139
	ldr	r3, [fp, #4]
	mov	r1, #0
	mov	r2, r0, asl #3
	str	r1, [fp, #-52]
	str	r3, [fp, #-44]
	str	r1, [fp, #-48]
	str	r2, [fp, #-40]
	mov	r2, r1
.L138:
	ldr	ip, [fp, #-48]
	ldr	r0, [fp, #-60]
	mov	r1, ip, asl #3
	add	r1, r0, r1
	mov	r9, r2, lsr #16
	mov	r0, r6
	mov	r2, sl
	bl	vec_copy
	cmp	r9, #0
	ldreq	r1, [fp, #-52]
	moveq	r8, r1, asl #3
	beq	.L136
	ldr	r2, [fp, #-52]
	ldr	r5, [fp, #4]
	mov	r4, #0
	mov	r8, r2, asl #3
.L137:
	ldr	r3, [fp, #-64]
	mov	r2, r4
	mov	r0, r6
	ldr	r1, [fp, #-56]
	str	r7, [sp, #0]
	bl	numt_copy_col
	mov	r2, sl
	mov	r0, r6
	mov	r1, r7
	bl	vec_dot
	mov	r3, r1
	mov	r2, r0
	add	r1, r8, r5
	stmia	r1, {r2-r3}
	mov	r0, r6
	mov	r1, r7
	bl	vec_mulc
	mov	r0, r6
	mov	r1, r7
	mov	r2, sl
	bl	vec_sub
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	ldr	r3, [fp, #-40]
	cmp	r4, r9
	add	r5, r5, r3
	bcc	.L137
.L136:
	mov	r0, r6
	mov	r1, sl
	bl	l2_norm
	ldr	ip, [fp, #-44]
	mov	r2, r0
	mov	r3, r1
	add	r1, r8, ip
	stmia	r1, {r2-r3}
	mov	r0, r6
	mov	r1, sl
	bl	vec_divc
	ldr	r0, [fp, #-52]
	ldr	ip, [fp, #-64]
	add	r0, r0, #1
	str	r0, [fp, #-52]
	mov	r2, r9
	mov	r0, r6
	mov	r1, r6
	mov	r3, sl
	str	ip, [sp, #0]
	bl	numt_set_col
	sub	r0, fp, #52
	ldmia	r0, {r0, r3}	@ phole ldm
	mov	r2, r0, asl #16
	ldr	ip, [fp, #-44]
	ldr	r1, [fp, #-56]
	ldr	r0, [fp, #-40]
	add	r3, r3, r6
	add	ip, ip, r0
	cmp	r1, r2, lsr #16
	str	r3, [fp, #-48]
	str	ip, [fp, #-44]
	bhi	.L138
.L139:
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L142:
	ldr	r0, .L143
	ldr	r1, .L143+4
	mov	r2, #44
	ldr	r3, .L143+8
	bl	__assert_fail
.L144:
	.align	2
.L143:
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
	beq	.L148
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L148:
	ldr	r3, .L149
	mov	r2, r4
	ldr	r0, [r3, #0]
	ldr	r1, .L149+4
	bl	fprintf
	mov	r0, r5
	bl	exit
.L150:
	.align	2
.L149:
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
	beq	.L154
	mov	r5, r1
	mov	r4, #0
.L153:
	ldmia	r5!, {r2-r3}
	ldr	r0, .L156
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r3, r4, #1
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r6, r4
	bhi	.L153
.L154:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L157:
	.align	2
.L156:
	.word	.LC0
	.size	printv, .-printv
	.align	2
	.global	printm
	.type	printm, %function
printm:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	subs	r9, r1, #0
	mov	r7, r0
	mov	r6, r2
	movne	r5, r3
	movne	sl, r2, asl #3
	movne	r8, #0
	beq	.L164
.L160:
	cmp	r6, #0
	movne	r4, #0
	beq	.L163
.L162:
	mov	r1, r4, asl #3
	add	r1, r5, r1
	ldmia	r1, {r2-r3}
	ldr	r0, .L166
	bl	printf
	mov	r0, r7
	bl	printf
	add	r2, r4, #1
	mov	r3, r2, asl #3
	cmp	r6, r2
	add	r3, r5, r3
	ldr	r0, .L166
	beq	.L161
	ldmia	r3, {r2-r3}
	bl	printf
	mov	r0, r7
	bl	printf
.L161:
	add	r3, r4, #2
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r6, r4
	bhi	.L162
.L163:
	mov	r0, #10
	bl	putchar
	add	r3, r8, #1
	mov	r3, r3, asl #16
	mov	r8, r3, lsr #16
	cmp	r9, r8
	add	r5, r5, sl
	bhi	.L160
.L164:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L167:
	.align	2
.L166:
	.word	.LC0
	.size	printm, .-printm
	.align	2
	.global	fprintm
	.type	fprintm, %function
fprintm:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r8, r1
	ldr	r1, .L176
	mov	fp, r2
	mov	r7, r3
	bl	openf
	cmp	fp, #0
	mov	r5, r0
	ldrne	r6, [sp, #40]
	movne	r9, r7, asl #3
	movne	sl, #0
	beq	.L169
.L170:
	cmp	r7, #0
	movne	r4, #0
	beq	.L173
.L172:
	mov	r1, r4, asl #3
	add	r1, r6, r1
	ldmia	r1, {r2-r3}
	mov	r0, r5
	ldr	r1, .L176+4
	bl	fprintf
	mov	r1, r8
	mov	r0, r5
	bl	fprintf
	add	r2, r4, #1
	mov	r3, r2, asl #3
	cmp	r2, r7
	add	r3, r6, r3
	mov	r0, r5
	ldr	r1, .L176+4
	beq	.L171
	ldmia	r3, {r2-r3}
	bl	fprintf
	mov	r0, r5
	mov	r1, r8
	bl	fprintf
.L171:
	add	r3, r4, #2
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r7, r4
	bhi	.L172
.L173:
	mov	r0, #10
	mov	r1, r5
	bl	fputc
	add	r3, sl, #1
	mov	r3, r3, asl #16
	mov	sl, r3, lsr #16
	cmp	fp, sl
	add	r6, r6, r9
	bhi	.L170
.L169:
	mov	r1, r5
	mov	r0, #10
	bl	fputc
	mov	r0, r5
	bl	fclose
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L177:
	.align	2
.L176:
	.word	.LC9
	.word	.LC0
	.size	fprintm, .-fprintm
	.align	2
	.global	fprintmt
	.type	fprintmt, %function
fprintmt:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r8, r1
	ldr	r1, .L186
	mov	fp, r2
	mov	r7, r3
	bl	openf
	cmp	fp, #0
	mov	r5, r0
	ldrne	r6, [sp, #40]
	movne	r9, r7, asl #3
	movne	sl, #0
	beq	.L179
.L180:
	cmp	r7, #0
	movne	r4, #0
	beq	.L183
.L182:
	mov	r1, r4, asl #3
	add	r1, r6, r1
	ldmia	r1, {r2-r3}
	mov	r0, r5
	ldr	r1, .L186+4
	bl	fprintf
	mov	r1, r8
	mov	r0, r5
	bl	fprintf
	add	r2, r4, #1
	mov	r3, r2, asl #3
	cmp	r2, r7
	add	r3, r6, r3
	mov	r0, r5
	ldr	r1, .L186+4
	beq	.L181
	ldmia	r3, {r2-r3}
	bl	fprintf
	mov	r0, r5
	mov	r1, r8
	bl	fprintf
.L181:
	add	r3, r4, #2
	mov	r3, r3, asl #16
	mov	r4, r3, lsr #16
	cmp	r7, r4
	bhi	.L182
.L183:
	mov	r0, #10
	mov	r1, r5
	bl	fputc
	add	r3, sl, #1
	mov	r3, r3, asl #16
	mov	sl, r3, lsr #16
	cmp	fp, sl
	add	r6, r6, r9
	bhi	.L180
.L179:
	mov	r1, r5
	mov	r0, #10
	bl	fputc
	mov	r0, r5
	bl	fclose
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L187:
	.align	2
.L186:
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
	ldr	r1, .L196
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
	beq	.L189
	mov	r3, r6, asl #3
	ldr	sl, [fp, #4]
	str	r3, [fp, #-48]
	mov	r8, #0
	sub	r9, fp, #40
.L192:
	mov	r1, #65536
	sub	r1, r1, #1
	ldr	r2, [fp, #-52]
	ldr	r0, [fp, #-60]
	bl	fgets
	ldr	r0, [fp, #-60]
	mov	r1, r7
	bl	strtok
	cmp	r6, #0
	beq	.L190
	mov	r5, sl
	mov	r4, #0
.L191:
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
	bhi	.L191
.L190:
	add	r3, r8, #1
	mov	r3, r3, asl #16
	ldr	r2, [fp, #-56]
	mov	r8, r3, lsr #16
	ldr	r3, [fp, #-48]
	cmp	r2, r8
	add	sl, sl, r3
	bhi	.L192
.L189:
	ldr	r0, [fp, #-52]
	bl	fclose
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L197:
	.align	2
.L196:
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
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, #5
	add	fp, sp, #32
	mov	r5, r1
	sub	sp, sp, #44
	mov	r1, #32	@ movhi
	strh	r1, [fp, #-38]	@ movhi
	bne	.L203
	ldmib	r5, {r3, ip}	@ phole ldm
	sub	r6, fp, #44
	mov	r2, #10
	ldr	r0, [r5, #12]
	mov	r1, r6
	str	ip, [fp, #-48]
	str	r3, [fp, #-52]
	bl	strtoull
	mov	r1, r6
	mov	r3, r0, asl #16
	mov	r2, #10
	ldr	r0, [r5, #16]
	mov	r5, r3, lsr #16
	bl	strtoull
	mov	r0, r0, asl #16
	mov	r6, r0, lsr #16
	mul	r3, r5, r6
	mul	r2, r5, r5
	mov	r3, r3, asl #3
	add	r3, r3, #8
	sub	sp, sp, r3
	mov	r2, r2, asl #3
	add	r1, sp, #8
	add	r2, r2, #8
	sub	sp, sp, r3
	add	ip, sp, #8
	sub	sp, sp, r2
	add	r4, sp, #8
	str	r1, [fp, #-60]
	sub	sp, sp, r3
	str	ip, [fp, #-64]
	add	r9, sp, #8
	mov	sl, #0
	mov	r7, #0
	mov	r8, #0
.L200:
	bl	clock
	mov	r1, r6
	str	r0, [fp, #-56]
	ldr	r2, [fp, #-60]
	mov	r0, r5
	bl	zero_m
	mov	r0, r6
	mov	r1, r5
	ldr	r2, [fp, #-64]
	bl	zero_m
	mov	r0, r5
	mov	r1, r5
	mov	r2, r4
	bl	zero_m
	mov	r0, r5
	mov	r1, r6
	mov	r2, r9
	bl	zero_m
	ldr	ip, [fp, #-60]
	ldr	r0, [fp, #-52]
	sub	r1, fp, #38
	mov	r2, r5
	mov	r3, r6
	str	ip, [sp, #0]
	bl	fscanm
	mov	r0, r5
	mov	r1, r6
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-64]
	bl	transpose_m
	mov	r0, r5
	mov	r1, r6
	ldr	r2, [fp, #-64]
	mov	r3, r4
	str	r9, [sp, #0]
	bl	QR
	ldr	r0, [fp, #-48]
	sub	r1, fp, #38
	mov	r2, r5
	mov	r3, r5
	str	r4, [sp, #0]
	bl	fprintmt
	mov	r2, r5
	mov	r3, r6
	sub	r1, fp, #38
	ldr	r0, [fp, #-48]
	str	r9, [sp, #0]
	bl	fprintmt
	bl	clock
	ldr	r1, [fp, #-56]
	rsb	r0, r1, r0
	bl	__aeabi_i2f
	mov	r1, #1224736768
	add	r1, r1, #7602176
	add	r1, r1, #9216
	bl	__aeabi_fdiv
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	mov	r1, r8
	mov	r0, r7
	bl	__aeabi_dadd
	add	r3, sl, #1
	mov	r3, r3, asl #16
	mov	sl, r3, lsr #16
	cmp	sl, #100
	mov	r7, r0
	mov	r8, r1
	bne	.L200
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #5832704
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L204
	bl	printf
	mov	r0, #0
	sub	sp, fp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L203:
	ldr	r0, .L204+4
	ldr	r1, .L204+8
	mov	r2, #15
	ldr	r3, .L204+12
	bl	__assert_fail
.L205:
	.align	2
.L204:
	.word	.LC13
	.word	.LC11
	.word	.LC12
	.word	.LANCHOR0+24
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	__PRETTY_FUNCTION__.3219, %object
	.size	__PRETTY_FUNCTION__.3219, 9
__PRETTY_FUNCTION__.3219:
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
	.type	__PRETTY_FUNCTION__.3631, %object
	.size	__PRETTY_FUNCTION__.3631, 5
__PRETTY_FUNCTION__.3631:
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
