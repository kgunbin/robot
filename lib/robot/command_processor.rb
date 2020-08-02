module Robot
  CommandProcessor = Struct.new(:state) do
    def execute(command, args)
      self.class.execute(state, command, args)
    end

    class << self
      def register_command(name, command)
        @commands[name] = command
      end

      # Attempt to execute a given command. Returns false if the command is not recognised
      def execute(state, command, args = nil)
        cmd = @commands[command]

        return { success: false, output: "Unknown command: #{command}" } if cmd.nil?

        # Passing down the state and agruments as a string.
        # Processors should mutate the state
        # Expected response is a hash including:
        #  - success: (true|false) - the result of command execution
        #  - output: - anything that should be sent to output in regular mode
        #  - error: - anything that should be sent to output in debug mode
        cmd.execute(state, args)
      end
    end

    private

    @commands = {}
  end
end
