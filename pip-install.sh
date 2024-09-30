#! /bin/bash

set -eou pipefail

NEXUS_ROOT=https://nexus.web.sandia.gov/

if curl --output /dev/null --silent --head --fail --max-time 10 "$NEXUS_ROOT"; then
  PIP_ARGS="--index-url=$NEXUS_ROOT/repository/pypi-proxy/simple"
else
  PIP_ARGS=""
fi

python3 -m pip install "$PIP_ARGS" cmakelang==0.6.13
