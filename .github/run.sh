#!/usr/bin/env sh

set -e

cd $(dirname "$0")/..

apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  python3-pip

python3 -m pip install -r requirements.txt

python3 run.py -k -v
