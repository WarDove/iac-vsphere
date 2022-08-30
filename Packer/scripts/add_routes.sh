#!/bin/bash

cp /tmp/add_routes.sh /etc/init.d/add_routes
chmod +x /etc/init.d/add_routes
echo '@reboot  /etc/init.d/add_routes' > /tmp/cron_job
crontab /tmp/cron_job
