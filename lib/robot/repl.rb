module Robot
  # The REPL implementation which captures user input, parses the arguments and calls the command processor
  Repl = Struct.new(:processor, :io) do
    def proceed
      while (buf = io.read)
        begin
          # Parsing the user input and extract the arguments from the command
          command, *args = buf.split(' ')

          # Process the command
          res = processor.execute(command, args&.flatten&.join(','))

          io.write(res)
        rescue StandardError => e
          io.error(e)
        end
      end
    rescue Interrupt
      io.write(output: 'Goodbye')
    end
  end
end
