require 'readline'

module Robot
  # The REPL implementation which captures user input, parses the arguments and calls the command processor
  Repl = Struct.new(:processor, :debug) do
    def proceed
      while (buf = self.class.read_line)
        begin
          # Parsing the user input
          command, *args = buf.split(' ')

          # Process the command
          res = processor.execute(command, args&.flatten&.join(','))

          self.class.write_line res[:output] if res[:success] && !res[:output].nil?
          self.class.write_line "DEBUG: #{res[:error]}" if debug && res[:success] == false
        rescue StandardError => e
          self.class.write_line "ERROR: #{e.message}" if debug
        end
      end
    rescue Interrupt
      self.class.write_line 'Goodbye'
    end

    # The IO is separated for testing purposes
    # TODO: Could be injected as a separate IOProcessor instance if more that one source of IO is expected
    class << self
      # Reading the STDIN
      # Separated in a method for testing purposes
      def read_line
        Readline.readline('> ', true)
      end

      # Writing to STDOUT
      def write_line(value)
        puts value
      end
    end
  end
end
