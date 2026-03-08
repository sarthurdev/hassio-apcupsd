#!/usr/bin/with-contenv bashio

set -e

CABLE=$(bashio::config 'cable')
TYPE=$(bashio::config 'type')
DEVICE=$(bashio::config 'device')

sed -i "s/^#\?UPSCABLE\( .*\)\?\$/UPSCABLE $CABLE/g" /etc/apcupsd/apcupsd.conf
sed -i "s/^#\?UPSTYPE\( .*\)\?\$/UPSTYPE $TYPE/g" /etc/apcupsd/apcupsd.conf
sed -i "s/^#\?DEVICE\( .*\)\?\$/DEVICE $DEVICE/g" /etc/apcupsd/apcupsd.conf

exec /sbin/apcupsd -b
