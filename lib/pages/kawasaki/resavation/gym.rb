require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/floor'
require './lib/pages/kawasaki/resavation/calender'


module Pages
  module Kawasaki
    module Reservation
      class Gym < Pages::Page
        
        def get_all_element
          find_element_by_partial_link_text( 'すべて' )
        end

        def get_target_element( taget )
          find_element_by_partial_link_text( taget )
        end

        def click_all
          get_all_element.click
          Pages::Kawasaki::Reservation::Floor.new( @driver, @wait )
        end

        def click_target( target )
          get_target_element( target ).click
          nextPage = Pages::Kawasaki::Reservation::Floor.new( @driver, @wait )

          # コートが1つのみの場合はフロア選択画面が出ないのでチェック
          if !nextPage.get_all_link_present?
            nextPage = Pages::Kawasaki::Reservation::Calender.new( @driver, @wait )
          end

          nextPage
        end

      end # Gym
    end # Reservation
  end # Kawasaki
end # Pages