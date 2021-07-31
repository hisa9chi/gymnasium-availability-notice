require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/game'

module Pages
  module Kawasaki
    module Reservation
      class Classification < Pages::Page
        
        def get_indoor_ball_game_element
          find_element_by_partial_link_text( '屋内・球技' )
        end

        def click_indoor_ball_game
          get_indoor_ball_game_element.click
          Pages::Kawasaki::Reservation::Game.new( @driver, @wait )
        end

      end # Classification
    end # Reservation
  end # Kawasaki
end # Pages