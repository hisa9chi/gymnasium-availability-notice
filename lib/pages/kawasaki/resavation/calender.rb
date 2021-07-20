require "./lib/pages/page.rb"
require './lib/pages/kawasaki/top_menu'
require './lib/pages/kawasaki/resavation/game'

module Pages
  module Kawasaki
    module Reservation
      class Calender < Pages::Page
        
        # メニューのホームボタン
        def getMenuHomeElement
          element_list = findElementsByXpath( '//*[@id="menu"]/ul/li[*]/a' )
          element_list.each do |element|
            if element.text == "ホーム"
              return element
            end
          end
        end

        # 前の施設ボタン
        def getPreviousFloorElement
          element_list = findElementsByXpath( '//*[@id="rsvmonth1"]/div[*]/input' )
          element_list.each do |element|
            if element.attribute('type') == 'button'
              if element.attribute('value') == '前の施設'
                return element
              end
            end
          end
        end

        # 前の施設ボタンが存在するかチェック
        def checkPreviousFloorElement?
          element_list = findElementsByXpath( '//*[@id="rsvmonth1"]/div' )
          if element_list.size > 1
            true
          else
            false
          end
        end
        
        # 次の施設ボタン
        def getNextFloorElement
          element_list = findElementsByXpath( '//*[@id="rsvmonth2"]/div[*]/input' )
          element_list.each do |element|
            if element.attribute('type') == 'button'
              if element.attribute('value') == '次の施設'
                return element
              end
            end
          end
        end

        # 次の施設ボタンが存在するかチェック
        def checkNextFloorElement?
          element_list = findElementsByXpath( '//*[@id="rsvmonth2"]/div' )
          if element_list.size > 1
            true
          else
            false
          end
        end

        # 体育館名をフロア名込みで取得
        def getGymFloorName
          findElementByXpath( '//*[@id="rsvmonth3"]/table/caption' ).text.gsub( ' ', '' ).chomp('空き状況')
        end

        # 年月日の取得
        def getYearMonth
          findElementByClass( 'm_akitablelist_head' ).text
        end

        # 前の月の要素取得
        def getPreviousMonthElement
          element_list = findElementByClass( 'm_akitablelist_head' ).find_elements( :tag_name, 'input' )
          element_list.each do |element|
            if element.attribute( 'value' ) == "前の月"
              return element
            end
          end
        end

        # 次の月の要素取得
        def getNextMonthElement
          element_list = findElementByClass( 'm_akitablelist_head' ).find_elements( :tag_name, 'input' )
          element_list.each do |element|
            if element.attribute( 'value' ) == "次の月"
              return element
            end
          end
        end
        
        def getAvailableDaysElements
          available_day_list = []
          yearMonth = getYearMonth

          element_list = findElementsByXpath( '//*[@id="rsvmonth3"]/table/tbody/tr[*]/td' )
          element_list.each do |element|
            if element.text.match( /\d+日/ )
              state = element.find_element( :tag_name, 'img' ).attribute( 'alt' )
              if state == "全て空き" || state == "#{yearMonth}#{element.text}一部空き"
                  puts state
                available_day_list.push( element )
              end
            end
          end
          available_day_list
        end

        def clickReservation
          getReservationElement.click
          Pages::Kawasaki::Reservation::Menu.new( @driver, @wait )
        end

        def getGymName
          findElementByXpath( '//*[@id="rsvmonth3"]/table/caption/a' ).attribute( 'text' )
        end
        
        def clickPreviousFloor
          getPreviousFloorElement.click
        end

        def clickNextFloor
          getNextFloorElement.click
        end

        def clickMenuHome
          getMenuHomeElement.click
          Pages::Kawasaki::TopMenu.new( @driver, @wait )
        end

        def clickPreviousMonth
          getPreviousMonthElement.click
        end

        def clickNextMonth
          getNextMonthElement.click
        end

      end # Calender
    end # Reservation
  end # Kawasaki
end # Pages