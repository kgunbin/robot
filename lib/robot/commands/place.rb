require_relative 'command'

module Robot
  module Commands
    class Place
      include Command

      register_with_name 'PLACE'

      def execute(state, args)
        x, y, d = args.split(',')[0..2]

        x = Integer(x)
        y = Integer(y)

        msg = state.place(x, y, d)

        [msg.nil?, msg]
      rescue ArgumentError => e
        [false, e.message]
      end
    end
  end
end
