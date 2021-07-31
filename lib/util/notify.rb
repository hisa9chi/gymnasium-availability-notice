require 'json'
require "date"
require 'line_notify'

module Lib
  module Util
    class Notify

      DAY_OF_WEEK = [ "日", "月", "火", "水", "木", "金", "土" ]

      # 指定したtoken を利用して message を LINE Notify で送る
      def send_line( token, message )
        line_notify = LineNotify.new( token )
        options = { message: message }
        line_notify.ping( options )
      end
      
      # hash 形式のデータから送信用のメッセージ作成
      def create_notify_message( area, hash_obj )
        message = "\n" + area + "\n"

        hash_obj['gyms'].each do |gym|
          message += "> " + gym['name'] + "\n"
          gym['floors'].each do |floor|
            message += "-- " + floor['name'] + "\n"
            floor['availables'].each do |available|
              message += "  | " + available['day'] + " (" + get_day_of_week( available['day'] ) + ") : " + available['classes'].join( ',' ) + "\n"
            end
          end
        end
        message
      end

      # 曜日を返却
      def get_day_of_week( day )
        date = Date.strptime( day, '%Y-%m-%d' )
        DAY_OF_WEEK[date.wday]
      end

    end # Notify
  end #Util
end # Lib