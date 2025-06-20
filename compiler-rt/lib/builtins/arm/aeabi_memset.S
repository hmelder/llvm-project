//===-- aeabi_memset.S - EABI memset implementation -----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "../assembly.h"

//  void __aeabi_memset(void *dest, size_t n, int c) { memset(dest, c, n); }
//  void __aeabi_memclr(void *dest, size_t n) { __aeabi_memset(dest, n, 0); }

        .syntax unified
        .p2align 2
DEFINE_COMPILERRT_FUNCTION(__aeabi_memset)
#if defined(__ARM_FEATURE_BTI_DEFAULT)
        bti
#endif
        mov     r3, r1
        mov     r1, r2
        mov     r2, r3
#ifdef USE_THUMB_1
        push    {r7, lr}
        bl      memset
        pop     {r7, pc}
#else
        b       memset
#endif
END_COMPILERRT_FUNCTION(__aeabi_memset)

DEFINE_AEABI_FUNCTION_ALIAS(__aeabi_memset4, __aeabi_memset)
DEFINE_AEABI_FUNCTION_ALIAS(__aeabi_memset8, __aeabi_memset)

        .p2align 2
DEFINE_COMPILERRT_FUNCTION(__aeabi_memclr)
#if defined(__ARM_FEATURE_BTI_DEFAULT)
        bti
#endif
        mov     r2, r1
        movs    r1, #0
#ifdef USE_THUMB_1
        push    {r7, lr}
        bl      memset
        pop     {r7, pc}
#else
        b       memset
#endif
END_COMPILERRT_FUNCTION(__aeabi_memclr)

DEFINE_AEABI_FUNCTION_ALIAS(__aeabi_memclr4, __aeabi_memclr)
DEFINE_AEABI_FUNCTION_ALIAS(__aeabi_memclr8, __aeabi_memclr)

NO_EXEC_STACK_DIRECTIVE

