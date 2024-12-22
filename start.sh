#!/bin/bash
set -e

bin/city_care eval "CityCare.Release.migrate"
bin/city_care start

exec "$@"
