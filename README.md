Project Setup
=============

##### Bundle

1. `rvm use 1.9.3`
2. `bundle install`

##### Database

1. copy `config/database.yml.example` to `config/database.yml`
2. setup host, user, password, database both in `development` and `test`
3. `bundle exec rake db:create`
4. `bundle exec rake db:migrate`


##### Basic config

1. copy `config/setting.yml.example` to `config/setting.yml`
2. setup fields as in .example (`app_name`, `aws:*`)

Generate Initital Data
======================

##### Admin user

* `bundle exec rake dev:fake` to create default user
* user: `aws@marsz.tw` passowrd: `12341234`
* see in `lib/tasks/dev.rake`
* please delete this user after created new one with is_admin = true

TODOs
=====

1. Custom aws access key & secret with multiple accounts & regions
2. More permissions in cancan
3. Rspec testing