require 'date'
require 'holiday_jp'

module Lib
  module Util
    class DayUtil

      # 土日祝日を判定
      def self.check_jp_holiday_and_day_off( day )
        date = Date.strptime( day, '%Y-%m-%d' )
        [ 0, 6 ].include?( date.wday ) or HolidayJp.holiday?( date )
      end

      # 曜日を返却 ※祝日の場合は '祝' を付加
      def self.get_day_of_week( day )
        day_of_week = [ "日", "月", "火", "水", "木", "金", "土" ]

        date = Date.strptime( day, '%Y-%m-%d' )
        result = day_of_week[ date.wday ]
        if HolidayJp.holiday?( date )
          "#{day_of_week[ date.wday ]}・祝"
        else
          day_of_week[ date.wday ]
        end
      end

    end # DayUtil
  end # Util
end # Lib

