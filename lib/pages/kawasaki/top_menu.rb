require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/menu'

module Pages
  module Kawasaki
    class TopMenu < Pages::Page

      def getReservationElement
        findElementByLink( '予約' )
      end

      def clickReservation
        getReservationElement.click
        Pages::Kawasaki::Reservation::Menu.new( @driver, @wait )
      end

    end # TopMenu
  end # kawasaki
end # Pages