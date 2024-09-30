#! /bin/bash

set -eou pipefail

NEXUS_ROOT=https://nexus.web.sandia.gov/

if curl --output /dev/null --silent --head --fail --max-time 10 "$NEXUS_ROOT"; then
  python3 -m pip install --index-url=$NEXUS_ROOT/repository/pypi-proxy/simple cmakelang==0.6.13
else
  python3 -m pip install cmakelang==0.6.13
fi
