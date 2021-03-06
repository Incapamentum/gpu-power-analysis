# Notes on Specific PTX Instructions

## Directives

### .visible

- Declares the identifier to be globally visible to other modules

### .entry

- Specifies the entry point and body of the kernel, with optional params

## State Space

### .params

- Defines one of the following:
  - Kernel params, **defined per-grid**
  - Function or local params, **defined per-thread**

### .reg

- Defines a register (fast)

## Data Types

| **Basic Type**   | **Fundamental Type Specifier**    |
| ---------------- | --------------------------------- |
| Signed Integer   | `.s8`, `.s16`, `.s32`, `.s64`     |
| Unsigned Integer | `.u8`, `.u16`, `.u32`, `.u64`     |
| Floating-Point   | `.f16`, `.f16x2`, `.f32 `, `.f64` |
| Bits (untyped)   | `.b8`, `.b16`, `.b32`, `.b64`     |
| Predicate        | `.pred`                           |

## Integer Arithmetic Instructions

### mul

- Multiply two values
- `mul.mode.type d, a, b;`
- `.mode = { .hi, .lo, .wide };`
- `.type = { .u16, .u32, .u64, .s16, .s32, s64 };`
- The `.type` of the operation represents the types of the `a` and `b` operands. If `.hi` or `.lo` is specified, then `d` is the same size as `a` and `b`, and either the upper or lower half of the result is written to the destination register. If `.wide` is specified, then `d` is twice as wide as `a` and `b` to receive the full result of the multiplication
- The `.wide` suffice is supported only for 16- and 32-bit integer types

## Floating-Point Instructions

### fma

- Performs a fused multiply-add with no loss of precision in the intermediate product and addition
- `fma.rnd{.ftz}{.sat}.f32 d, a, b, c`
- `.rnd = { .rn, .rz, .rm, .rp };`

## Comparison & Selection Instructions

### setp

- Compare two numeric values with a relational operator, and (optionally) combine this result with a predicate value by applying a Boolean operator
- ``` setp.CmpOp.type p, a, b; // Applies CmpOp to a, b; result stored in p```
- ``` .CmpOp = {eq, ne, lt, le, gt, ge, lo, ls, hi, hs, equ, neu, ltu, leu, gtu, geu, num, nan }; // Set of possible comparison operators```

## Data Movement

### ld

- Load a register var from an addressable state space
- Instruction `ld.param` is used to pass values from host to kernel

### st

- Store a register variable to an addressable state space variable
- ``` st.global.type [a], b; // stores value of register b in locaton specified by a to global memory```

### cvta

- Convert address from `const`, `global`, `local`, or `shared` state space to generic (or vice-versa)
- ``` cvta.space.size p, a; // source address in register a```

## Control Flow Instructions

### @ (predicated execution)

- Execute an instruction (or instruction block) for threads that have the guard predicate `True`. Threads with a `False` guard predicate do nothing
- **Semantics**: if `{!}p` then instruction

### bra

- Branch to a target and continue execution there
- **Semantics**: ``` if (p) { pc = tgt; }```