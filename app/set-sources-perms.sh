#!/bin/bash

find ../sources/*/*/var/cache -maxdepth 0 -exec chmod -R 777 {} \;
find ../sources/*/*/var/logs -maxdepth 0 -exec chmod -R 777 {} \;
find ../sources/*/*/var/build -maxdepth 0 -exec chmod -R 777 {} \;

# EOF
