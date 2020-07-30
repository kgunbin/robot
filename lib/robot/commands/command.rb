require_relative '../command_processor'

module Robot
  module Commands
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
        def register_with_name(name)
          # Register a new instance of command processor against the command it processes
          ::Robot::CommandProcessor.register_command(name, self.new)
        end
      end
    end
  end
end
