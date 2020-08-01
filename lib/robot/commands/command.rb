require_relative '../command_processor'

module Robot
  module Commands
    # A common module for command processing
    # Every command should include this module and register itself to execute when certain user input has occured
    # using 'register_with_name "SOME_INPUT"'.
    # Each command can handle several different inputs.
    # The command implemetation should have an "execute_command" method implemented.
    module Command
      # Could use ActiveSupport::Concern but don't want such heavy dependency
      def self.included(base)
        base.extend(ClassMethods)
      end

      def execute(state, args)
        output = execute_command(state, args)
        { success: true, output: output }
      rescue ::Robot::StateException, ::Robot::CommandException => e
        { success: false, error: e.message }
      end

      def execute_command(*)
        raise 'Not implemented'
      end

      module ClassMethods
        # Register a new instance of command processor against the command it processes
        def register_with_name(name)
          ::Robot::CommandProcessor.register_command(name, new)
        end
      end
    end
  end
end
