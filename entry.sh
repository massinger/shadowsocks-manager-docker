#!/bin/bash

cd /etc/shadowsocks 


cp -n ssmgr.yml.example ssmgr.yml 
cp -n webui.yml.example webui.yml && sed -i "s/'username'/'$username'/g" webui.yml && sed -i "s/'password'/'$password'/g" webui.yml && sed -i "s/'smtp_server'/'$smtp_server'/g" webui.yml && sed -i "s/'site_host'/'$site_host'/g" webui.yml

cp -n ss-server.json.example ss-server.json


/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

