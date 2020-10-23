module Robot
  module Commands
    class GoTo
      include Command

      register_with_name 'GOTO'

      def execute_command(state, args)
        finder = PathFinder.new(state, args.split(',')[0..1].map(&:to_i))
        finder.go.to_s
      rescue ArgumentError, TypeError => e
        raise Robot::CommandException, e
      end

      class PathFinder
        attr_reader :visited, :state, :finish

        def initialize(state, finish)
          @visited = [state.position]
          @state = state
          @finish = finish
        end

        def go
          catch(:done) do
            move([state.position], state.direction)
          end
        end

        def move(track, direction)
          # Finished
          if track[-1] == finish
            # Update the state
            state.place(finish[0], finish[1], direction)

            # Publish the track
            throw :done, track
          end

          begin
            # One step in a current direction
            next_step = state.class.next_position(track[-1], direction)

            # Visited already
            return if visited.include?(next_step)

            visited << next_step

            # Check bumps
            state.check_cell(*next_step)

            # All good move ahead
            move(track + [next_step], direction)
          rescue StateException
            3.times do
              direction = state.class.turn(true, direction)
              # Hit something, turning 3 times
              move(track, direction)
            end
          end

          # No path
          nil
        end
      end
    end
  end
end
