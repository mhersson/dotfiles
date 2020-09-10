#!/bin/bash

class="up"

text=
text="$(nmcli c show --active | awk '{print $1}' | grep -E "PIA|Stibo" | paste -s -d'+' || echo "Down")"

if [ "${text}"  == "Down" ]; then
    class="down"
elif [ "${text: -1}" == "+" ]; then
    text="${text::-1}"
fi

echo \{ \"text\": \""${text}"\", \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
