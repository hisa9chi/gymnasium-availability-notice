require 'line_notify'

module Lib
  class Notify

    # 指定したtoken を利用して message を LINE Notify で送る
    def send_line( message, token )
      line_notify = LineNotify.new( token )
      options = { message: message }
      line_notify.ping( options )
    end

  end # Notify
end # Lib