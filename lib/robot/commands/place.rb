require_relative 'command'

module Robot
  module Commands
    class Place
      include Command

      register_with_name 'PLACE'

      def execute_command(state, args)
        x, y, d = args.split(',')[0..2]

        x = Integer(x)
        y = Integer(y)

        state.place(x, y, d)
      rescue ArgumentError, TypeError => e
        { success: false, error: e.message }
      end
    end
  end
end
