require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/gym'

module Pages
  module Kawasaki
    module Reservation
      class Game < Pages::Page
        
        def get_basketball_element
          find_element_by_partial_link_text( 'バスケットボール' )
        end

        def click_basketball
          get_basketball_element.click
          Pages::Kawasaki::Reservation::Gym.new( @driver, @wait )
        end

      end # Game
    end # Reservation
  end # Kawasaki
end # Pages