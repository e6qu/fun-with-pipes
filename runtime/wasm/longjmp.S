.globl __c_longjmp
.tagtype __c_longjmp i32
__c_longjmp:

.functype fwp_lj_prepare (i32, i32) -> (i32)

.globl __wasm_longjmp
.type __wasm_longjmp,@function
__wasm_longjmp:
  .functype __wasm_longjmp (i32, i32) -> ()
  local.get 0
  local.get 1
  call fwp_lj_prepare
  throw __c_longjmp
  unreachable
  end_function
