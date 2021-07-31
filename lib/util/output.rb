require 'json'

module Lib
  module Util
    class Output

      def self.json_file( file_name, map_obj )
        output_path = "result/#{file_name}.json"
        json_str = JSON.generate( map_obj )

        File.open( output_path, "w" ) do |file| 
          file.puts json_str
        end
      end

    end # Output
  end # Util
end # Lib

