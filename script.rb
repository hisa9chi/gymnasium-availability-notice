require 'selenium-webdriver'
require 'hashie'

require './lib/client/kawasaki'
require './lib/util/output'

cmnConf = Hashie::Mash.load( 'config/common.yml' )

wait = Selenium::WebDriver::Wait.new( :timeout => 1 )
driver = Selenium::WebDriver.for( :chrome )

# 川崎
indivConf = Hashie::Mash.load( 'config/kawasaki.yml' )
kawasaki = Lib::Client::Kawasaki.new( driver, wait, cmnConf, indivConf )
kawasaki.checkAvailabilityGym

kawasaki.destroy


# output = Lib::Util::Output.new
# output.createJsonData