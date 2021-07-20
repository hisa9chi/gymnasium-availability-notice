require './lib/pages/kawasaki/login'
require './lib/pages/kawasaki/resavation/floor'

module Lib
  module Client
    class Kawasaki
      # 川崎市の体育館空き情報を格納
      @kawasakiGyms = []

      def initialize( driver, wait, cmnConf, indivConf )
        @driver = driver
        @wait = wait
        @cmnConf = cmnConf
        @indivConf = indivConf
      end

      # 川崎で申込可能な体育館の空きをチェック
      def checkAvailabilityGym
        # ログイン
        topMenuPage = login
        # 平日・休日の確認対象体育館のチェック
        topMenuPage = checkGym( topMenuPage, 0 )
        # 休日のみの確認対象体育館のチェック
        topMenuPage = checkGym( topMenuPage, 1 )
      end

      # 会員ページへログイン
      def login
        @driver.navigate.to( @indivConf.login_url )
        loginPage = Pages::Kawasaki::Login.new( @driver, @wait )
        loginPage.login( @indivConf.user.id, @indivConf.user.pass )
      end

      # 対象の体育館をチェックする
      # type=0: 平日・休日チェック対象、type=1: 休日チェック対象 
      def checkGym( topMenuPage, type )
        case type
        when 0 then
          gymList = @indivConf.gym.all_day
        when 1 then
          gymList = @indivConf.gym.day_off
        else
          gymList = []
        end

        gymList.each do |gym|
          puts gym
          rsvGym = moveGymSelectList( topMenuPage )
          rsvCalender = moveGymAvailabilityCalender( rsvGym, gym )

          # フロアごとの空き情報を格納
          floors = []

          while true do
            floorName = rsvCalender.getGymFloorName.gsub( gym, '' )
            puts floorName

            # 日毎の空きの確認
            availables = checkFloor( rsvCalender, type )

            # 空きが存在すればデータをpush
            floors.push( {"name" => gymFloorName, "available" => availables} ) until availables.empty?

            # 次のフロアへ移動
            if rsvCalender.checkNextFloorElement?
              rsvCalender.clickNextFloor
            else
              break
            end
          end

          # その体育館に空きがあれば空き情報を push
          @kawasakiGyms.push( {'gym' => {"name" => gym, "floor" => floors}} ) until floors.empty?

          # メニューのホーム画面をクリック
          topMenuPage = rsvCalender.clickMenuHome
        end
        topMenuPage
      end

      # 体育館のフロア単位で空きを確認する
      def checkFloor(rsvCalender, type)
        # 空きの情報
        availables = []

        # 1月分の確認
        @cmnConf.check_month.times do |i|
          availabilityElements = getAvailableDay( rsvCalender )
          availabilityElements.each do |element|
            availables.push( {"day" => "#{rsvCalender.getYearMonth}#{element.text}", "class" => []} )
            puts "#{rsvCalender.getYearMonth}#{element.text}"
          end

          # 翌月へ移動
          rsvCalender.clickNextMonth if i < @cmnConf.check_month - 1
        end

        # 当月まで戻す
        (@cmnConf.check_month-1).times do |i|
          rsvCalender.clickPreviousMonth
        end

        availables
      end

      # 体育館選択ページへ遷移
      def moveGymSelectList( topMenuPage )
        rsvMenu = topMenuPage.clickReservation
        rsvClassification = rsvMenu.clickFromPurpose
        rsvGame = rsvClassification.clickIndoorBallGame
        rsvGame.clickBasketball
      end

      # 空き状況確認ページへの遷移
      def moveGymAvailabilityCalender( rsvGym, target )
        nextPage = rsvGym.clickTarget( target )
        if nextPage.instance_of?( Pages::Kawasaki::Reservation::Floor )
          nextPage = nextPage.clickAllLink
        end
        nextPage
      end

      # 空きがある日程を取得
      def getAvailableDay( rsvCalender )
        rsvCalender.getAvailableDaysElements
      end

      def destroy
        @driver.quit
      end
    
    end # Kawasaki
  end # Client
end # Lib