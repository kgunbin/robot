require 'rubygems'
require 'bundler/setup'
require 'byebug'

require './lib/robot/exceptions'
require './lib/robot/cli'
require './lib/robot/repl'
require './lib/robot/state'

module Robot
  def self.start
    options = CLI.options
    state = State.new(options[:size])

    Repl.new(state, options[:debug]).proceed
  end
end
