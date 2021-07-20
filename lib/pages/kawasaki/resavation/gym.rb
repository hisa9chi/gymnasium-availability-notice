require "./lib/pages/page.rb"
require './lib/pages/kawasaki/resavation/floor'
require './lib/pages/kawasaki/resavation/calender'


module Pages
  module Kawasaki
    module Reservation
      class Gym < Pages::Page
        
        def getAllElement
          findElementByPartialLinkText( 'すべて' )
        end

        def getTargetElement( taget )
          findElementByPartialLinkText( taget )
        end

        def clickAll
          getAllElement.click
          Pages::Kawasaki::Reservation::Floor.new( @driver, @wait )
        end

        def clickTarget( target )
          getTargetElement( target ).click
          nextPage = Pages::Kawasaki::Reservation::Floor.new( @driver, @wait )

          # コートが1つのみの場合はフロア選択画面が出ないのでチェック
          if !nextPage.getAllLinkPresent?
            nextPage = Pages::Kawasaki::Reservation::Calender.new( @driver, @wait )
          end

          nextPage
        end

      end # Gym
    end # Reservation
  end # Kawasaki
end # Pages