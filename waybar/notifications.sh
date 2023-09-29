#!/usr/bin/env bash

class="default"
tooltip="notifications are active"

if $(dunstctl is-paused); then
  class="paused"
  tooltip="notifications are paused"
fi

echo "{\"class\":\"$class\", \"tooltip\":\"$tooltip\"}"
