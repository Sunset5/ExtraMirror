#!/bin/sh
if grep -q ExtraMirror.so /proc/$(pidof hl_linux)/maps; then
  exit 1
fi

sudo gdb -n -q -batch \
  -ex "attach $(pidof hl_linux)" \
  -ex "set \$dlopen = (void*(*)(char*, int)) dlopen" \
  -ex "call \$dlopen(\"$(pwd)/ExtraMirror.so\", 1)" \
  -ex "detach" \
-ex "quit"
