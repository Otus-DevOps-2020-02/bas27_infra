# bas27_infra
bas27 Infra repository

```
bastion_IP = 35.228.32.71 \
someinternalhost_IP = 10.166.0.3
```

## Подключение к хосту в одну команду

В качестве варианта использовал назначение переменной:

```
export S = 'ssh someinternalhost'
```

Проверка использования:
`
$S`

### Дополнительное задание

Для подключения к удаленным хостам используя алиас необходимо:

* Создать файл ~/.ssh/ssh_config
* Добавить в него следующий конфиг
```
Host someinternalhost
        Hostname 35.228.32.71
        User bas
        Port 22
        IdentityFile /home/bas/.ssh/bas
        LogLevel VERBOSE
        RequestTTY force
        RemoteCommand ssh 10.166.0.3
        ForwardAgent yes
```

## #DZ_4
### GCP_CreateInstanceWithMetadata

```
testapp_IP = 35.205.18.137
testapp_port = 9292
```
```
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
```

### GCP_CreateFirewallRule

```
gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --target-tags=puma-server --source-ranges=0.0.0.0/0
```

## DZ_5

### Сборка образа VM с помощью Packer

* Подготовлен шаблон сборки VM _ubuntu16.json_
* Подготовлен шаблон с обязательными переменными _variables.json_

Проверка на ошибки в шаблоне:
```
packer validate ./ubuntu16.json
```
Сборка образа:
```
packer build -var-file=variables.json ubuntu16.json
```
* Создан шаблон _immutable.json_, который включает все зависимости запускаемого приложения
* Создан файл _packer.service_, который отвечает за автозапуск сервера PUMA
* Создан скрипт _create-reddit-vm.sh_, который запустит виртуальную машину из подготовленного образа (работает при наличии сетевого правила в файерволе)
