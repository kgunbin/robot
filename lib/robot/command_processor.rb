module Robot
  class CommandProcessor
    @commands = {}

    def self.register_command(name, command)
      @commands[name] = command
    end

    # Attemt to execute a given command. Returns false if the command is not recognised
    def self.execute(state, command, args = nil)
      command = @commands[command]

      return { success: false, error: "Unknown command: #{command}" } if command.nil?

      # Passing down the state and agruments as a string. Processors should mutate the state
      command.execute(state, args)
    end
  end
end
