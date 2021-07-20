require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/gym'

module Pages
  module Kawasaki
    module Reservation
      class Game < Pages::Page
        
        def getBasketballElement
          findElementByPartialLinkText( 'バスケットボール' )
        end

        def clickBasketball
          getBasketballElement.click
          Pages::Kawasaki::Reservation::Gym.new( @driver, @wait )
        end

      end # Game
    end # Reservation
  end # Kawasaki
end # Pages