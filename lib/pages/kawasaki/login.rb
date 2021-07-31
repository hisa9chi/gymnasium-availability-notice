require "./lib/pages/page.rb"
require './lib/pages/kawasaki/top_menu'

module Pages
  module Kawasaki
    class Login < Pages::Page

      def get_user_id_element
        find_element_by_id( 'userId' )
      end

      def get_password_element
        find_element_by_id( 'pass' )
      end

      def get_login_element
        element_list = find_elements_by_xpath( '//*[@id="login"]/ul/li[*]/input' )
        element_list.each do |element|
          if element.attribute( 'type' ) == 'submit'
            if element.attribute( 'value' ) == 'ログイン'
              return element
            end
          end
        end
      end

      def set_user_id( id )
        get_user_id_element.send_keys( id )
      end

      def set_password( pass )
        get_password_element.send_keys( pass )
      end

      def login( id, pass )
        set_user_id( id )
        set_password( pass )
        get_login_element.click
        Pages::Kawasaki::TopMenu.new( @driver, @wait )
      end

    end # Login
  end # Kawasaki
end # Pages