module Robot
  State = Struct.new(:size) do
    attr_reader :position, :direction

    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    def place(x, y, d)
      return "Direction must be one of #{DIRECTIONS.join(',')}" unless !d.nil? && DIRECTIONS.include?(d)
      if (range_error = _check_range(x, y))
        return range_error
      end

      @position = [x, y]
      @direction = d
      @initialised = true

      nil
    end

    def move
      _when_initialised do
        new_x, new_y = position

        case direction
        when 'NORTH'
          new_y += 1
        when 'SOUTH'
          new_y -= 1
        when 'EAST'
          new_x -= 1
        when 'WEST'
          new_x += 1
        else
          # Redundant as "place" validates the direction
          return "Unknown direction #{direction}"
        end

        if (range_error = _check_range(new_x, new_y))
          return range_error
        end

        @position = [new_x, new_y]

        nil
      end
    end

    def turn(left)
      _when_initialised do
        idx = DIRECTIONS.index(direction)
        idx = (left ? idx - 1 : idx + 1) % DIRECTIONS.size

        @direction = DIRECTIONS[idx]
        nil
      end
    end

    private

    def _check_range(x, y)
      return 'X is out of range' unless !x.nil? && x >= 0 && x < size
      return 'Y is out of range' unless !y.nil? && y >= 0 && y < size
      nil
    end

    def _when_initialised
      return 'Not initialised' unless initialised
      yield
    end

    attr_accessor :initialised
  end
end
