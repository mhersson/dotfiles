#!/usr/bin/env bash

class="default"

if $(dunstctl is-paused); then
  class="paused"
fi

echo \{ \"class\": \""${class}"\", \"alt\": \""${class}"\" \}
