require_relative 'command'

module Robot
  module Commands
    class Right
      include Command

      register_with_name 'RIGHT'

      def execute_command(state, _args)
        state.turn(false)
      end
    end
  end
end
