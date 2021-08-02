# gymnasium-availability-notice

## environment

- HEADLESS_ON: hedless mode の有効無効（true/false）
- KAWASAKI_USER_ID: 川崎予約システムログインユーザID
- KAWASAKI_USER_PASS: 川崎予約システムログインユーザIDのパスワード
- LINE_NOTIFY_TOKEN: LINE Notify 用の token

## execution
```
$ bundle config set --local path 'vendor/bundle'
$ bundle config set --local without 'development' 
$ bundle install

$ bundle exec ruby script.rb
```
