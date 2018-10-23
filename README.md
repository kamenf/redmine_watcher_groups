## Redmine Watcher Groups compatible with Redmine 3.2.0 (3.2.1) and Rails 4.2.5 (4.2.5.2)

Plugin for Redmine that adds functionality to have Watcher Groups in additioan to Watchers.

Adds new list in the showed Issue sidebar which lists added Watcher Groups and allows to add/remove groups to that list.

All notifications to invovled in a issue users (watchers + involved) are sent also to the current members of all added groups.

When you add a group to observers, its members did not not appear in the list of observers, unlike other forks. This functionality was I really needed.

## How to install

To install the redmine watcher groups plugin, execute the following commands from the root of your redmine directory, assuming that your RAILS_ENV enviroment variable is set to "production":

    git clone git://github.com/roma-sk3/redmine_watcher_groups.git
    bundle install
    rake redmine:plugins:migrate NAME=redmine_watcher_groups RAILS_ENV=production

Migration is not required!

## Плагин для Redmine 3.2.0 (3.2.1) and Rails 4.2.5 (4.2.5.2) - "Группы наблюдателей"

Данный плагин позволяет добавлять в наблюдатели группы. Добавляет новый блок справа в задачах и позволяет добалять/удалять группы в этом списке.

Все уведомления отправляются также членам всех добавленных групп.

В отличии от других форков этого плагина, здесь при добавлении группы в наблюдатели, ее члены не появляются в общем списке.

## Как установить

Для установки необходимо выполнить данные команды, установив переменную среды RAILS_ENV в "production":

    git clone git://github.com/roma-sk3/redmine_watcher_groups.git
    bundle install
    rake redmine:plugins:migrate NAME=redmine_watcher_groups RAILS_ENV=production

Миграция не требуется!
