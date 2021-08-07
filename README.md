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
$ bundle install

# export で事前に環境変数を設定している場合
$ bundle exec ruby script.rb

# 環境変数を実行時に指定する場合
$ HEADLESS_ON=false LINE_NOTIFY_TOKEN='xxxx' KAWASAKI_USER_ID='yyyy' KAWASAKI_USER_PASS='zzzzz' bundle exec ruby script.rb
```

## Setting
- [common.yml](./config/common.yml) 体育館の空き状況確認の共通設定
  - check_month: 何ヶ月分チェックするかを数値で指定  ※当月含む
- [kawasaki.yml](./config/kawasaki.yml) 川崎の体育館の設定
  - gym.all_day: ここに記載した体育館は平日の夜間と土日祝日の全日程を通知対象とする
  - gym.day_off: ここに記載した体育館は土日祝日の全日程を通知対象とする
