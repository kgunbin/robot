module Robot
  # The state of the toy robot
  State = Struct.new(:size, :obstacles) do
    attr_reader :position, :direction

    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    class << self
      def next_position(position, direction)
        new_x, new_y = position

        case direction
        when 'NORTH' then new_y += 1
        when 'SOUTH' then new_y -= 1
        when 'EAST' then new_x += 1
        when 'WEST' then new_x -= 1
        else
          # Redundant as "place" validates the direction
          raise StateException, "Unknown direction #{direction}"
        end

        [new_x, new_y]
      end

      def turn(left, direction)
        idx = DIRECTIONS.index(direction)
        DIRECTIONS[(left ? idx - 1 : idx + 1) % DIRECTIONS.size]
      end
    end

    # Place the robot on a board
    # @x - the X position
    # @y - the Y position
    # @direction - initial direction the robit is facing
    def place(x, y, direction)
      unless !direction.nil? && DIRECTIONS.include?(direction)
        raise StateException, "Direction must be one of #{DIRECTIONS.join(',')}"
      end

      check_cell(x, y)

      @position = [x, y]
      @direction = direction
      @initialised = true

      nil
    end

    # Move the robot 1 step towards current direction
    def move
      _when_initialised do
        new_x, new_y = self.class.next_position(position, direction)
        check_cell(new_x, new_y)
        move_to(new_x, new_y)

        nil
      end
    end

    def move_to(x, y)
      _when_initialised do
        @position = [x, y]
      end
    end

    # Turns the robot 90 degrees
    # @left - if true, robot turns anti-clockwise, if false - clockwise
    def turn(left)
      _when_initialised do
        @direction = self.class.turn(left, direction)
        nil
      end
    end

    # Reports the surrent position and direction of the robot
    def report
      _when_initialised { (position + [direction]).join(',') }
    end

    def check_cell(x, y)
      raise StateException, "X (#{x}) is out of range" unless !x.nil? && x >= 0 && x < size
      raise StateException, "Y (#{y}) is out of range" unless !y.nil? && y >= 0 && y < size
      raise StateException, "An obstacle" if obstacles.any? { |(o_x, o_y)| o_x == x && o_y == y }
    end

    private

    def _when_initialised
      raise StateException, 'Not initialised' unless initialised

      yield
    end

    attr_accessor :initialised
  end
end
