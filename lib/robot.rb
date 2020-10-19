require 'rubygems'
require 'bundler/setup'

# Load everything from the lib/robot first
Dir.glob(File.dirname(__FILE__) + '/robot/*.rb').sort.each(&method(:require))
# Recursively load and register all available commands
Dir.glob(File.dirname(__FILE__) + '/robot/commands/*.rb').sort.each(&method(:require))

#
# Robot movement simulator
#
module Robot
  def self.start
    options = CLI.options

    obstacles = seed_obstacles(options[:size], options[:num_obstacles])

    state = State.new(options[:size], obstacles)
    processor = CommandProcessor.new(state)
    io = IO.new(options[:debug])

    Repl.new(processor, io).proceed
  end

  private_class_method def self.seed_obstacles(size, num_obstacles)
    sq = size ** 2
    raise "Too many obstacles, should no more than #{sq}" if num_obstacles > sq

    rest = num_obstacles
    ret = []

    while rest.positive?
      x = rand(size)
      y = rand(size)
      next if ret.find { |(o_x, o_y)| o_x == x && o_y == y }
      ret << [x, y]
      rest -= 1
    end
    ret
  end
end
