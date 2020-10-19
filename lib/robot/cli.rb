require 'optionparser'
require_relative 'version'

module Robot
  # Handles the command line arguments and the defaults
  class CLI
    class << self
      def options
        options = { size: 5, debug: false, num_obstacles: 0 }

        OptionParser.new do |opts|
          opts.on('-sSIZE', '--size=SIZE', "Board size. Defaults to #{options[:size]}") do |s|
            options[:size] = Integer(s)
          rescue ArgumentError
            puts "Incorrect value for -s argument - #{s}. Must be an integer"
            exit
          end

          opts.on('-v', '--version', 'Show version and exit') do
            puts Robot::VERSION
            exit
          end
          opts.on('-oNUM', '--num-obstacles=NUM', 'Number of the obstacles on the board') do |n|
            options[:num_obstacles] = n.to_i
          end
          opts.on('-d', '--debug', 'Print debug messages') { |x| options[:debug] = x }
          opts.on('-h', '--help', 'Prints help message') do |x|
            puts opts
            exit
          end
        end.parse!

        options
      end
    end
  end
end
