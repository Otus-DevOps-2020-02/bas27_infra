# bas27_infra
bas27 Infra repository

-------------------------
bastion_IP = 35.228.32.71 \
someinternalhost_IP = 10.166.0.3
-------------------------

#Подключение к хосту в одну команду

В качестве варианта использовал назначение переменной:

export S = 'ssh someinternalhost'

Проверка использования:

$S

#Дополнительное задание

Для подключения к удаленным хостам используя алиас необходимо:

1. Создать файл ~/.ssh/ssh_config
2. Добавить в него следующий конфиг

Host someinternalhost \
        Hostname 35.228.32.71 \
        User bas \
        Port 22 \
        IdentityFile /home/bas/.ssh/bas \
        LogLevel VERBOSE \
        RequestTTY force \
        RemoteCommand ssh 10.166.0.3 \
        ForwardAgent yes \
------------------------
# GCP_CreateInstanceWithMetadata (#DZ_4)

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup-script.sh \
 or \
  --metadata startup-script-url=gs://baldin/startup-script.sh

# GCP_CreateFirewallRule (#DZ_4)

gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --target-tags=puma-server --source-ranges=0.0.0.0/0
