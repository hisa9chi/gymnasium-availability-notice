require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/classification'

module Pages
  module Kawasaki
    module Reservation
      class Menu < Pages::Page
        
        def getFromPurposeElement
          element_list = findElementsByXpath( '//*[@id="select-func"]/ul/li[*]/input' )
          element_list.each do |element|
            if element.attribute('type') == 'submit'
              if element.attribute('value') == '利用目的から'
                return element
              end
            end
          end
        end

        def clickFromPurpose
          getFromPurposeElement.click
          Pages::Kawasaki::Reservation::Classification.new( @driver, @wait )
        end

      end # Menu
    end # Reservation
  end # Kawasaki
end # Pages