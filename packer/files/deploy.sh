#/bin/bash

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

cp gs://baldin/puma.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable puma.service
systemctl start puma.service
