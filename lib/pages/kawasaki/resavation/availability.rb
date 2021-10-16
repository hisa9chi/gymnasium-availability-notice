require "./lib/pages/page.rb"

module Pages
  module Kawasaki
    module Reservation
      class Availability < Pages::Page

        # "もどる"ボタン
        def get_return_button_element
          element_list = find_elements_by_xpath( '//*[@id="rsvaki10"]/input' )
          printf( "      > elements: %d\n", element_list.length )
          element_list.each do |element|
            printf( "       >> type = %s / value = %s \n", element.attribute( 'type' ), element.attribute( 'value' ) )
            if element.attribute( 'type' ) == 'button'
              if element.attribute( 'value' ) == 'もどる'
                return element
              end
            end
          end
        end
        
        # 空き状況詳細の区分を取得
        def get_available_class
          available_class_list = []
          element_list = 0
          retry_cnt = 3
          retry_sleep = 2   # sec
          retry_cnt.times do |i|
            element_list = find_elements_by_xpath( '//*[@id="rsvaki3"]/table/tbody/tr' )
            if element_list.length > 0
              break
            end
            sleep retry_sleep
          end

          printf( "       >> ヘッダ数：%d\n", element_list.length )
          element_list.each do |element|
            class_list = element.find_elements( :xpath, 'td' )
            printf( "        >>> 予約枠：%d\n", class_list.length )
            unless class_list.empty?
              class_name = element.find_element( :xpath, 'th' ).text
              printf( "         >>>> 状況：%s\n", class_list[0].find_element( :tag_name, 'img' ).attribute( 'alt' ) )
              if class_list[0].find_element( :tag_name, 'img' ).attribute( 'alt' ).end_with?( "空き" )
                available_class_list.push( class_name )
              end
            end
          end
          available_class_list
        end

        def click_return_button
          get_return_button_element.click
        end

      end # Availability
    end # Reservation
  end # Kawasaki
end # Pages
