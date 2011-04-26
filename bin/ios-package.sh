#!/bin/bash
TARGET=ipa-debug
SIGNING_ROOT=~/Mobile_Flash
KEYSTORE=$SIGNING_ROOT/dww-iphone.p12
PROVISIONING=$SIGNING_ROOT/Flash_Profile.mobileprovision
HOST_IP=127.0.0.1
DESCRIPTOR=PlayingFlashApp-app.xml
OUTPUT_NAME=PlayingFlashApp.ipa

INPUT_FILES="\
PlayingFlashApp.swf \
"

adt -package -target $TARGET -connect $HOST_IP -storetype pkcs12 -keystore $KEYSTORE -provisioning-profile $PROVISIONING $OUTPUT_NAME $DESCRIPTOR $INPUT_FILES
