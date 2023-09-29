#!/usr/bin/env bash

class="up"

if (piactl get connectionstate | grep -i disconnected >/dev/null); then
  class="down"
fi

echo \{ \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
