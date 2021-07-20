require 'json'

module Lib
  module Util
    class Output

      def createJsonData
        availables = []
        item = { "day" => "2021年8月1日", "class" => [ "午前", "夜間" ] }
        availables.push( item )
        item = { "day" => "2021年8月2日", "class" => [ "夜間" ] }
        availables.push( item )

        floors = []
        floor = { "name" => "A", "available" => availables }
        floors.push( floor )

        availables = []
        item = { "day" => "2021年8月1日", "class" => [ "午前", "夜間" ] }
        availables.push( item )
        item = { "day" => "2021年8月2日", "class" => [ "夜間" ] }
        availables.push( item )
        floor = { "name" => "B", "available" => availables }
        floors.push( floor )

        gym = { "floor" => floors }

        json_str = JSON.pretty_generate(gym)
        puts json_str
      end

      def outputFile
        File.open("meibo.json","w") {|file| 
          file.puts people2
        }
      end

    end # Output
  end # Util
end # Lib

