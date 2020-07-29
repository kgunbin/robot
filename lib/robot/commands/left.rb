require_relative 'command'

module Robot
  module Commands
    class Left
      include Command

      register_with_name 'LEFT'

      def execute(state, _args)
        msg = state.turn(true)
        [msg.nil?, msg]
      end
    end
  end
end
