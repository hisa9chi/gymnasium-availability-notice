require "./lib/pages/page.rb"
require './lib/pages/kawasaki/top_menu'

module Pages
  module Kawasaki
    class Login < Pages::Page

      def getUserIdElement
        findElementById( 'userId' )
      end

      def getPasswordElement
        findElementById( 'pass' )
      end

      def getLoginElement
        element_list = findElementsByXpath( '//*[@id="login"]/ul/li[*]/input' )
        element_list.each do |element|
          if element.attribute('type') == 'submit'
            if element.attribute('value') == 'ログイン'
              return element
            end
          end
        end
      end

      def setUserId(id)
        getUserIdElement.send_keys( id )
      end

      def setPassword(pass)
        getPasswordElement.send_keys( pass )
      end

      def login(id, pass)
        setUserId(id)
        setPassword(pass)
        getLoginElement.click
        Pages::Kawasaki::TopMenu.new( @driver, @wait )
      end

    end # Login
  end # Kawasaki
end # Pages