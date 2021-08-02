# gymnasium-availability-notice
指定した体育館の空き状況を確認して LINE Notify を利用して特定の LINE グループに通知するスクリプト

## Requirements
- ruby 2.7.4
- chromedriver 92.0.4515.107

## Environment
| key | type | description |
|-|:-:|-|
| HEADLESS_ON | boolean |hedless mode の有効無効 |
| LINE_NOTIFY_TOKEN | string |LINE Notify 用の token |
| KAWASAKI_USER_ID | string | 川崎予約システムログインユーザID |
| KAWASAKI_USER_PASS | string | 川崎予約システムログインユーザIDのパスワード |

## Execution
```
$ bundle config set --local path 'vendor/bundle'
$ bundle config set --local without 'development' 
$ bundle install

# export で事前に環境変数を設定している場合
$ bundle exec ruby script.rb

# 環境変数を実行時に指定する場合
$ HEADLESS_ON=false LINE_NOTIFY_TOKEN='xxxx' KAWASAKI_USER_ID='yyyy' KAWASAKI_USER_PASS='zzzzz' bundle exec ruby script.rb
```
