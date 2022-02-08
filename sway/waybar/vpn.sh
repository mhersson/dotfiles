#!/bin/bash

class="down"

country=$(protonvpn-cli status | grep Country | awk '{print $2}')
if [ "${country}" != "" ];then
  class="up"
fi

echo \{ \"text\": \""${country}"\", \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
