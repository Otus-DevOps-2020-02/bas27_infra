# bas27_infra
bas27 Infra repository

-------------------------
bastion_IP = 35.228.32.71
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

Host someinternalhost
        Hostname 35.228.32.71
        User bas
        Port 22
        IdentityFile /home/bas/.ssh/bas
        LogLevel VERBOSE
        RequestTTY force
        RemoteCommand ssh 10.166.0.3
        ForwardAgent yes
