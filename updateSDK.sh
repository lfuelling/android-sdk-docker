#!/bin/sh
expect -c '
set timeout -1   ;
spawn sudo /opt/android-sdk-linux/tools/android update sdk --no-ui --all; 
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'