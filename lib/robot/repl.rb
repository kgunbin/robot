require 'readline'
require_relative 'command_processor'
# Recursively load and register all available commands
Dir.glob(File.dirname(__FILE__) + '/commands/*', &method(:require))

module Robot
  Repl = Struct.new(:state, :debug) do
    def proceed
      while (buf = self.class.read_line)
        begin
          # Parsing the user input
          command, *args = buf.split(' ')

          # Process the command
          # Returns result (bool) and debug message
          res = CommandProcessor.execute(state, command, args&.flatten&.join(','))

          puts res[:output] if res[:success] && !res[:output].nil?
          puts "DEBUG: #{res[:error]}" if debug && res[:success] == false
        rescue StandardError => e
          puts "ERROR: #{e.message}" if debug
        end
      end
    rescue Interrupt
      puts 'Goodbye'
    end

    def self.read_line
      Readline.readline('> ', true)
    end
  end
end
