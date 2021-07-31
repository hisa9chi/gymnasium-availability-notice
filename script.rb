require 'selenium-webdriver'
require 'hashie'

require './lib/client/kawasaki'
require './lib/util/output'

# 共通設定
cmn_conf = Hashie::Mash.load( 'config/common.yml' )

# headless option
options = Selenium::WebDriver::Chrome::Options.new
if ENV['HEADLESS_ON'] =~ /(true|True|TRUE)/
  options.add_argument( '--headless' )  
elsif 
  options.add_argument( 'window-size=1024,1024' )  
end  

driver = Selenium::WebDriver.for( :chrome, options: options )
wait = Selenium::WebDriver::Wait.new( :timeout => 1 )

# 川崎
kawasaki_conf = Hashie::Mash.load( 'config/kawasaki.yml' ).merge( cmn_conf )
kawasaki = Lib::Client::Kawasaki.new( driver, wait, kawasaki_conf )
gym_availabilites_list = kawasaki.check_availability_gym
kawasaki.destroy

puts gym_availabilites_list


# # output = Lib::Util::Output.new
# output.createJsonData