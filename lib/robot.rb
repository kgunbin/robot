require 'rubygems'
require 'bundler/setup'

require './lib/robot/exceptions'
require './lib/robot/cli'
require './lib/robot/repl'
require './lib/robot/state'

# The order of code loading is important here
require './lib/robot/command_processor'
# Recursively load and register all available commands
Dir.glob(File.dirname(__FILE__) + '/robot/commands/*').sort.each(&method(:require))

#
# Robot movement simulator
#
module Robot
  def self.start
    options = CLI.options
    state = State.new(options[:size])
    processor = CommandProcessor.new(state)

    Repl.new(processor, options[:debug]).proceed
  end
end
