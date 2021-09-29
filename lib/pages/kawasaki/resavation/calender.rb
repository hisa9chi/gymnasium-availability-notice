require "./lib/pages/page.rb"
require './lib/pages/kawasaki/top_menu'
require './lib/pages/kawasaki/resavation/game'
require './lib/pages/kawasaki/resavation/availability'

module Pages
  module Kawasaki
    module Reservation
      class Calender < Pages::Page
        
        # メニューのホームボタン
        def get_menu_home_element
          element_list = find_elements_by_xpath( '//*[@id="menu"]/ul/li[*]/a' )
          element_list.each do |element|
            if element.text == "ホーム"
              return element
            end
          end
        end

        # 前の施設ボタン
        def get_previous_floor_element
          element_list = find_elements_by_xpath( '//*[@id="rsvmonth1"]/div[*]/input' )
          element_list.each do |element|
            if element.attribute( 'type' ) == 'button'
              if element.attribute( 'value' ) == '前の施設'
                return element
              end
            end
          end
        end

        # 前の施設ボタンが存在するかチェック
        def check_previous_floor_element?
          element_list = find_elements_by_xpath( '//*[@id="rsvmonth1"]/div' )
          if element_list.size > 1
            true
          else
            false
          end
        end
        
        # 次の施設ボタン
        def get_next_floor_element
          element_list = find_elements_by_xpath( '//*[@id="rsvmonth2"]/div[*]/input' )
          element_list.each do |element|
            if element.attribute( 'type' ) == 'button'
              if element.attribute( 'value' ) == '次の施設'
                return element
              end
            end
          end
        end

        # 次の施設ボタンが存在するかチェック
        def check_next_floor_element?
          element_list = find_elements_by_xpath( '//*[@id="rsvmonth2"]/div' )
          if element_list.size > 1
            true
          else
            false
          end
        end

        # 体育館名をフロア名込みで取得
        def get_gym_floor_name
          find_element_by_xpath( '//*[@id="rsvmonth3"]/table/caption' ).text.gsub( ' ', '' ).chomp( '空き状況' )
        end

        # 年月日の取得
        def get_year_month
          find_element_by_class( 'm_akitablelist_head' ).text
        end

        # 前の月の要素取得
        def get_previous_month_element
          element_list = find_element_by_class( 'm_akitablelist_head' ).find_elements( :tag_name, 'input' )
          element_list.each do |element|
            if element.attribute( 'value' ) == "前の月"
              return element
            end
          end
        end

        # 次の月の要素取得
        def get_next_month_element
          element_list = find_element_by_class( 'm_akitablelist_head' ).find_elements( :tag_name, 'input' )
          element_list.each do |element|
            if element.attribute( 'value' ) == "次の月"
              return element
            end
          end
        end
        
        # 空きがある日付の一覧を取得
        def get_available_days
          available_day_list = []
          year_month = get_year_month

          element_list = find_elements_by_xpath( '//*[@id="rsvmonth3"]/table/tbody/tr[*]/td' )
          element_list.each do |element|
            if element.text.match( /\d+日/ )
              state = element.find_element( :tag_name, 'img' ).attribute( 'alt' )
              if state == "全て空き" || state == "#{year_month}#{element.text}一部空き"
                available_day_list.push( element.text )
              end
            end
          end
          available_day_list
        end

        # 日付の要素を取得
        def get_day_element( day )
          element_list = find_elements_by_xpath( '//*[@id="rsvmonth3"]/table/tbody/tr[*]/td' )
          element_list.each do |element|
            if element.text.match( day )
              printf( "      > day: %s\n", element.text )
              return element
            end
          end
        end

        def click_reservation
          get_reservation_element.click
          Pages::Kawasaki::Reservation::Menu.new( @driver, @wait )
        end

        def get_gym_name
          find_element_by_xpath( '//*[@id="rsvmonth3"]/table/caption/a' ).attribute( 'text' )
        end
        
        def click_previous_floor
          get_previous_floor_element.click
        end

        def click_next_floor
          get_next_floor_element.click
        end

        def click_menu_home
          get_menu_home_element.click
          Pages::Kawasaki::TopMenu.new( @driver, @wait )
        end

        def click_previous_month
          get_previous_month_element.click
        end

        def click_next_month
          get_next_month_element.click
        end

        def click_day( day )
          get_day_element( day ).click
          Pages::Kawasaki::Reservation::Availability.new( @driver, @wait )
        end

      end # Calender
    end # Reservation
  end # Kawasaki
end # Pages