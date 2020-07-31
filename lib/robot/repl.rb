require 'readline'
require_relative 'command_processor'
# Recursively load and register all available commands
Dir.glob(File.dirname(__FILE__) + '/commands/*').sort.each(&method(:require))

module Robot
  Repl = Struct.new(:state, :debug) do
    def proceed
      while (buf = self.class.read_line)
        begin
          # Parsing the user input
          command, *args = buf.split(' ')

          # Process the command
          # Returns result (bool) and a message/error
          res = CommandProcessor.execute(state, command, args&.flatten&.join(','))

          self.class.write_line res[:output] if res[:success] && !res[:output].nil?
          self.class.write_line "DEBUG: #{res[:error]}" if debug && res[:success] == false
        rescue StandardError => e
          self.class.write_line "ERROR: #{e.message}" if debug
        end
      end
    rescue Interrupt
      self.class.write_line 'Goodbye'
    end

    # Reading the STDIN
    # Separated in a method for testing purposes
    def self.read_line
      Readline.readline('> ', true)
    end

    # Writing to STDOUT
    def self.write_line(value)
      puts value
    end
  end
end
