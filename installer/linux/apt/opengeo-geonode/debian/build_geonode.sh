#!/usr/bin/env bash

set -e

python bootstrap.py
source bin/activate
paver name="GeoNode-1.2-SUITE-SNAPSHOT" make_release
deactivate
