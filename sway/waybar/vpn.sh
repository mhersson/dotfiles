#!/bin/bash

class="up"

state=
state=$(piactl get connectionstate)

region=
region=$(piactl get region)


if [ "${state}"  != "Connected" ]; then
    class="down"
fi

echo \{ \"text\": \""${state} ${region^}"\", \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
