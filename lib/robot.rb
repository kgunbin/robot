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
    state = State.new(options[:size])
    processor = CommandProcessor.new(state)
    io = IO.new(options[:debug])

    Repl.new(processor, io).proceed
  end
end
