require_relative '../spec_helper'
require_relative '../../lib/robot'

describe Robot, type: :integration do
  subject(:work) { described_class.start }

  before do
    # Using a partial double to keep asserting against STDOUT output
    allow(Robot::IO).to receive(:new).and_return(io)
    # Stub user input, taking commands from the "queue" until it is empty
    allow(io).to receive(:read) do
      cmd = queue.shift
      raise Interrupt if cmd.nil?

      cmd
    end

    # Stub CLI with default options
    allow(Robot::CLI).to receive(:options).and_return(options)
  end

  let(:options) { { size: 5, debug: true } }
  let(:io) { Robot::IO.new(options[:debug]) }

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
      expect { work }.to output(/2,2,WEST/).to_stdout
    end
  end

  context 'unknown commands' do
    let(:queue) { %w[MAP LOOK SET AHEAD DROP JUNK] }

    it 'ignores without exception' do
      expect do
        expect { work }.to output(/Unknown command/).to_stdout
      end.not_to raise_exception
    end
  end

  context 'with a huge board and number of commands', slow: true do
    let(:size) { 10e5.to_i }
    let(:options) { super().merge(size: size) }
    let(:queue) do
      q = ['PLACE 0,0,NORTH']
      size.times do
        place = [rand(size), rand(size), %w[NORTH SOUTH EAST WEST][rand(4)]].join(',')

        q << (%w[LEFT RIGHT MOVE REPORT] | ["PLACE #{place}"])[rand(5)]
      end
      q
    end

    it 'works, stays polite and never throws an exception' do
      expect do
        expect { work }.to output(/Goodbye/).to_stdout
      end.not_to raise_exception
    end
  end
end
