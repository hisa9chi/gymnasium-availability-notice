require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/calender'

module Pages
  module Kawasaki
    module Reservation
      class Floor < Pages::Page
        
        def getAllLinkElement
          findElementByPartialLinkText( 'すべて' )
        end

        def getAllLinkPresent?
          @driver.manage.timeouts.implicit_wait = 0
          @driver.find_element(:partial_link_text, 'すべて' )
          true
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end

        def clickAllLink
          getAllLinkElement.click
          Pages::Kawasaki::Reservation::Calender.new( @driver, @wait )
        end

      end # Floor
    end # Reservation
  end # Kawasaki
end # Pages