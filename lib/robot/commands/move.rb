require_relative 'command'

module Robot
  module Commands
    class Move
      include Command

      register_with_name 'MOVE'

      def execute_command(state, _args)
        state.move
      end
    end
  end
end
