require_relative 'command'

module Robot
  module Commands
    class Right
      include Command

      register_with_name 'RIGHT'

      def execute(state, _args)
        msg = state.turn(false)
        [msg.nil?, msg]
      end
    end
  end
end
