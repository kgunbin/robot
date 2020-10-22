module Robot
  module Commands
    class GoTo
      include Command

      register_with_name 'GOTO'

      def execute_command(state, args)
        finder = PathFinder.new(state, args.split(',')[0..1].map(&:to_i))
        finder.go
      end

      private

      class PathFinder
        attr_reader :visited, :state, :finish

        def initialize(state, finish)
          @visited = [[state.position]]
          @state = state
          @finish = finish
        end

        def go
          catch :done do
            move([state.position])
          end
        end

        def move(track, depth = 0)
          puts track: track
          # Finished
          throw :done, track if track[-1] == finish
          begin
            success = true
            # One step in a current direction
            state.move_with_confirmation do |next_step|
              # Visited already
              success = !visited.include?(next_step)

              success
            end
            return unless success
            # All good move ahead
            visited << state.position

            move(track << state.position)
          rescue StateException
            # Hit something, turning 3 times
            3.times do
              state.turn(true)
              move(track, depth + 1)
            end
          end
        end
      end
    end
  end
end
