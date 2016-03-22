#!/bin/sh
expect -c '
set timeout -1   ;
spawn sudo /opt/android-sdk-linux/tools/android update sdk --no-ui --all --filter tools,platform-tools,build-tools-23.0.2,build-tools-22.0.1,android-23,android-22,android-21,sys-img-armeabi-v7a-android-23,addon-google_apis-google-23,addon-google_apis-google-22,extra-android-m2repository,extra-android-support; 
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'