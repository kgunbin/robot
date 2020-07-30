require_relative 'command'

module Robot
  module Commands
    class Report
      include Command

      register_with_name 'REPORT'

      def execute_command(state, _args)
        state.report
      end
    end
  end
end
