require "./lib/pages/page.rb"

module Pages
  module Kawasaki
    module Reservation
      class Availability < Pages::Page

        # "もどる"ボタン
        def get_return_button_element
          element_list = find_elements_by_xpath( '//*[@id="rsvaki10"]/input' )
          element_list.each do |element|
            puts element
            if element.attribute( 'type' ) == 'button'
              puts element.attribute( 'type' )
              if element.attribute( 'value' ) == 'もどる'
                puts element.attribute( 'value' )
                return element
              end
            end
          end
        end
        
        # 空き状況詳細の区分を取得
        def get_available_class
          available_class_list = []
          element_list = find_elements_by_xpath( '//*[@id="rsvaki3"]/table/tbody/tr' )

          element_list.each do |element|
            class_list = element.find_elements( :xpath, 'td' )
            unless class_list.empty?
              class_name = element.find_element( :xpath, 'th' ).text
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
