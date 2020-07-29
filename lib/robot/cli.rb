require 'optionparser'
require_relative 'version'

module Robot
  class CLI
    class << self
      def options
        options = { size: 5, debug: false }

        OptionParser.new do |opts|
          opts.on('-sSIZE', '--size=SIZE', 'Board size') do |s|
            options[:size] = Integer(s)
          rescue ArgumentError
            puts "Incorrect value for -s argument - #{s}. Must be an integer"
            exit
          end

          opts.on('-v', '--version', 'Show version and exit') do
            puts Robot::VERSION
            exit
          end

          opts.on('-d', '--debug', 'Print debug messages') { |x| options[:debug] = x }
        end.parse!

        options
      end
    end
  end
end
