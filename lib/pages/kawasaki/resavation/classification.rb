require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/game'

module Pages
  module Kawasaki
    module Reservation
      class Classification < Pages::Page
        
        def getIndoorBallGameElement
          findElementByPartialLinkText( '屋内・球技' )
        end

        def clickIndoorBallGame
          getIndoorBallGameElement.click
          Pages::Kawasaki::Reservation::Game.new( @driver, @wait )
        end

      end # Classification
    end # Reservation
  end # Kawasaki
end # Pages