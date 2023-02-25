#!/bin/bash
EXE_NAME=""

_exec_payload() {
    PAYLOAD_LINE=$(grep -n "__PAYLOAD__" $0 | tail -n 1 | cut -d: -f1)
    BINARY_LINE=$(($PAYLOAD_LINE + 1))
    tail -n +${BINARY_LINE} $0 | base64 -d | tar -xjf - -C /tmp
    # execute the binary, no return
    exec /tmp/${EXE_NAME} $@
}

_exec_payload $@

# do not allow shell script to execute into the payload
exit 1
__PAYLOAD__
