require_relative 'command'

module Robot
  module Commands
    class Move
      include Command

      register_with_name 'MOVE'

      def execute(state, _args)
        msg = state.move
        [msg.nil?, msg]
      end
    end
  end
end
