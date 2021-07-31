require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/classification'

module Pages
  module Kawasaki
    module Reservation
      class Menu < Pages::Page
        
        def get_from_purpose_element
          element_list = find_elements_by_xpath( '//*[@id="select-func"]/ul/li[*]/input' )
          element_list.each do |element|
            if element.attribute( 'type' ) == 'submit'
              if element.attribute( 'value' ) == '利用目的から'
                return element
              end
            end
          end
        end

        def click_from_purpose
          get_from_purpose_element.click
          Pages::Kawasaki::Reservation::Classification.new( @driver, @wait )
        end

      end # Menu
    end # Reservation
  end # Kawasaki
end # Pages