set pagination off
break *fwp_apply_owned if *(unsigned int*)$x0 == 16 && *(unsigned int*)($x0+4) == 0
run
set $callback = *(unsigned long long*)$x2
printf "Callback before capture: %p\n", $callback
x/4gx $callback
watch *(unsigned int*)$callback
continue
bt
x/4gx $callback
info registers
