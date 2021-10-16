require 'selenium-webdriver'
require 'hashie'

require './lib/client/kawasaki'

# 共通設定
cmn_conf = Hashie::Mash.load( 'config/common.yml' )

# headless option
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument( 'window-size=1024,1024' )  
if "#{cmn_conf.headless_on}" =~ /(true|True|TRUE)/
  options.add_argument( '--headless' )
  options.add_argument( '--no-sandbox' )
end  

driver = Selenium::WebDriver.for( :chrome, options: options )
wait = Selenium::WebDriver::Wait.new( :timeout => 10 )

# 川崎
kawasaki_conf = Hashie::Mash.load( 'config/kawasaki.yml' ).merge( cmn_conf )
kawasaki = Lib::Client::Kawasaki.new( driver, wait, kawasaki_conf )
gym_availabilites_list = kawasaki.check_availability_gym
kawasaki.destroy
