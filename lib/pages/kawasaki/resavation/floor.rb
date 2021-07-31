require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/calender'

module Pages
  module Kawasaki
    module Reservation
      class Floor < Pages::Page
        
        def get_all_link_element
          find_element_by_partial_link_text( 'すべて' )
        end

        def get_all_link_present?
          @driver.manage.timeouts.implicit_wait = 0
          @driver.find_element(:partial_link_text, 'すべて' )
          true
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end

        def click_all_link
          get_all_link_element.click
          Pages::Kawasaki::Reservation::Calender.new( @driver, @wait )
        end

      end # Floor
    end # Reservation
  end # Kawasaki
end # Pages