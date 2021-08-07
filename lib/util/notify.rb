require 'json'
require "date"
require 'line_notify'

require './lib/util/day_util'

module Lib
  module Util
    class Notify

      # 指定したtoken を利用して hash_obj を通知用の形にして LINE Notify で送る
      # area は川崎、横浜、三田といったGエリアを指定
      def self.send_line( token, area, hash_obj )
        message = create_notify_message( area, hash_obj )
        line_notify = LineNotify.new( token )
        options = { message: message }
        line_notify.ping( options )
      end
      
      # hash 形式のデータから送信用のメッセージ作成
      def self.create_notify_message( area, hash_obj )
        message = "\n" + area + "\n"

        hash_obj['gyms'].each do |gym|
          message += "> " + gym['name'] + "\n"
          gym['floors'].each do |floor|
            message += "-- " + floor['name'] + "\n"
            floor['availables'].each do |available|
              message += "  | " + available['day'] + " (" + DayUtil.get_day_of_week( available['day'] ) + ") : " + available['classes'].join( ',' ) + "\n"
            end
          end
        end
        message
      end

    end # Notify
  end #Util
end # Lib