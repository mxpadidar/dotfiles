#!/bin/bash
set -euo pipefail

case "${script_type:?OpenVPN must set script_type}" in
  up)
    resolvectl dns "${dev:?OpenVPN must set dev}" 172.25.11.240
    resolvectl domain "$dev" '~iranianpooshesh.com' '~sanaap.co'
    ;;
  down)
    resolvectl revert "${dev:?OpenVPN must set dev}"
    ;;
esac
