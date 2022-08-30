#!/bin/bash

envsubst < /tmp/app_routes.tpl | cat | tee -a /etc/init.d/add_routes
chmod +x /etc/init.d/add_routes
echo '@reboot  /etc/init.d/add_routes' > /tmp/cron_job
crontab /tmp/cron_job
