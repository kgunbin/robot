require_relative 'command'

module Robot
  module Commands
    class Left
      include Command

      register_with_name 'LEFT'

      def execute_command(state, _args)
        msg = state.turn(true)
      end
    end
  end
end
