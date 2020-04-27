# bas27_infra
bas27 Infra repository

## DZ_11: Разработка и тестирование Ansible ролей и плейбуков

### Локальная разработка при помощи Vagrant, доработка ролей для провижининга в Vagrant

`vagrant -v` #смотрим версию

 - Описываем нашу инфраструктуру в файле `Vagrantfile`
 - Создадим виртуалки, описанные в Vagrantfile

`vagrant -up` #поднимаем нашу инфру
`vagrant box list` #проверим, что бокс скачался на нашу локальную машину
`vagrant status`
`vagrant ssh appserver`

 - Доработка ролей
Добавим провижининг в определение хоста.
Провижининг происходит автоматически при запуске новой машины, либо на отдельный хост `vagrant provision dbserver`

Переменные `extra_vars`, имеют самый высокий приоритет по сравнению со всеми остальными

`vagrant destroy -f` #удаление созданных машин

Тестирование ролей при помощи Molecule и Testinfra
`cd ./ansible/roles/db`

`molecule init scenario --scenario-name default -r db -d vagrant`

Описание тестовой машины, которая создается Molecule для тестов содержится в файле `db/molecule/default/molecule.yml`

Создадим VM для проверки роли. В директории ansible/roles/db выполните команду:
`molecule create`
`molecule list` #список созданных molecule инстансов
`molecule login -h instance` #подключиться по SSH внутрь VM
`molecule converge` #Применим playbook.yml, в котором вызывается наша роль
`molecule verify` #Прогоним тесты
Переключение сбора образов пакером на использование ролей

* Подключение Travis CI для автоматического прогона тестов
