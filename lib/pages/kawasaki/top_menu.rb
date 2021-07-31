require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/menu'

module Pages
  module Kawasaki
    class TopMenu < Pages::Page

      def get_reservation_element
        find_element_by_link( '予約' )
      end

      def click_reservation
        get_reservation_element.click
        Pages::Kawasaki::Reservation::Menu.new( @driver, @wait )
      end

    end # TopMenu
  end # kawasaki
end # Pages