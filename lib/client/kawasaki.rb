require 'date'

require './lib/util/output'
require './lib/util/notify'
require './lib/pages/kawasaki/login'
require './lib/pages/kawasaki/resavation/floor'

module Lib
  module Client
    class Kawasaki

      def initialize( driver, wait, config )
        @driver = driver
        @wait = wait
        @config = config
      end

      # 川崎で申込可能な体育館の空きをチェック
      def check_availability_gym
        puts "#- 川崎 ---------------"
        # ログイン
        top_menu_page = login
        available_gym_list = check_gym( top_menu_page )

        unless available_gym_list.empty?
          kawasaki_gyms = {"gyms" => available_gym_list}

          # ファイル出力
          Util::Output.json_file( "kawasaki", kawasaki_gyms )
          # LINE 通知
          notify = Util::Notify.new
          message = notify.create_notify_message( "川崎", kawasaki_gyms )
          notify.send_line( @config.line_notify_token, message )
        end
        puts "#---------------------"
      end

      # 会員ページへログイン
      def login
        @driver.navigate.to( @config.login_url )
        login_page = Pages::Kawasaki::Login.new( @driver, @wait )
        login_page.login( @config.user.id, @config.user.pass )
      end

      # 対象の体育館をチェックする
      def check_gym( top_menu_page )
        available_gym_list = []
        gym_list = @config.gym.all_day.concat( @config.gym.day_off )

        gym_list.each do |gym|
          printf( "[%s]\n",  gym )
          rsv_gym = move_gym_select_list( top_menu_page )
          rsv_calender = move_gym_availability_calender( rsv_gym, gym )

          # フロアごとの空き情報を格納
          floors = []

          while true do
            floor_name = rsv_calender.get_gym_floor_name.gsub( gym, '' )
            printf( " - %s\n", floor_name )

            # 日毎の空きの確認
            availables = check_floor( rsv_calender )

            # 空きが存在すればデータをpush            
            floors.push( {"name" => floor_name, "availables" => availables} ) unless availables.empty?

            # 次のフロアへ移動
            if rsv_calender.check_next_floor_element?
              rsv_calender.click_next_floor
            else
              break
            end
          end

          # その体育館に空きがあれば空き情報を push
          available_gym_list.push( {"name" => gym, "floors" => floors} ) unless floors.empty?

          # メニューのホーム画面をクリック
          top_menu_page = rsv_calender.click_menu_home
        end
        available_gym_list
      end

      # 体育館のフロア単位で空きを確認する
      def check_floor( rsv_calender )
        # 空きの情報
        availables = []

        # 1月分の確認
        @config.check_month.times do |i|
          year_month = rsv_calender.get_year_month
          available_days_list = rsv_calender.get_available_days
          
          available_days_list.each do |day|
            date = Date.strptime( "#{year_month}#{day}", '%Y年%m月%d日' )
            rsv_availability = rsv_calender.click_day( day )

            classes = rsv_availability.get_available_class
            unless classes.empty?
              item = { "day" => date.strftime( "%Y-%m-%d" ), "classes" => classes }
              printf( "    %s\n", item )
              availables.push( item )
            end

            rsv_availability.click_return_button
          end

          # 翌月へ移動
          rsv_calender.click_next_month if i < @config.check_month - 1
        end

        # 当月まで戻す
        (@config.check_month-1).times do |i|
          rsv_calender.click_previous_month
        end

        availables
      end

      # 体育館選択ページへ遷移
      def move_gym_select_list( top_menu_page )
        rsv_menu = top_menu_page.click_reservation
        rsv_classification = rsv_menu.click_from_purpose
        rsv_game = rsv_classification.click_indoor_ball_game
        rsv_game.click_basketball
      end

      # 空き状況確認ページへの遷移
      def move_gym_availability_calender( rsv_gym, target )
        next_page = rsv_gym.click_target( target )
        if next_page.instance_of?( Pages::Kawasaki::Reservation::Floor )
          next_page = next_page.click_all_link
        end
        next_page
      end

      # driver を破棄
      def destroy
        @driver.quit
      end
    
    end # Kawasaki
  end # Client
end # Lib