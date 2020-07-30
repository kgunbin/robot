require_relative '../spec_helper'
require_relative '../../lib/robot'

describe Robot do
  subject(:work) { described_class.start }

  before do
    # Stub user input, taking commands from the "queue" until it is empty
    allow(Robot::Repl).to receive(:read_line) do
      cmd = queue.shift
      raise Interrupt if cmd.nil?
      cmd
    end

    # Stub CLI with default options
    allow(Robot::CLI).to receive(:options).and_return(options)
  end

  let(:options) { { size: 5, debug: true } }

  context 'walking the spiral' do
    let(:queue) do
      [
        'PLACE 0,0,EAST',
        'MOVE',
        'MOVE',
        'MOVE',
        'MOVE',
        'LEFT',
        'MOVE',
        'MOVE',
        'MOVE',
        'LEFT',
        'MOVE',
        'MOVE',
        'LEFT',
        'MOVE',
        'RIGHT',
        'REPORT'
      ]
    end

    it 'ends up where expected' do
      expect { work }.to output('3,3,S').to_stdout
    end
  end
end
