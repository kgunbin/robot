require_relative '../../../spec_helper'
require_relative '../../../../lib/robot'

describe Robot::Commands::GoTo do
  before { state.place(0, 0, 'EAST') }

  context 'when finding its way in the field with obstacles' do
    let(:state) do
      Robot::State.new(10, [[1, 1], [6, 6], [7, 0], [8, 7]])
    end

    subject(:goto) { described_class.new.execute_command(state, '9,9') }

    it 'gets to the finish' do
      expect(goto).to eq [
        [0, 0],
        [1, 0],
        [2, 0],
        [3, 0],
        [4, 0],
        [5, 0],
        [6, 0],
        [6, 1],
        [6, 2],
        [6, 3],
        [6, 4],
        [6, 5],
        [5, 5],
        [4, 5],
        [3, 5],
        [2, 5],
        [1, 5],
        [0, 5],
        [0, 6],
        [0, 7],
        [0, 8],
        [0, 9],
        [1, 9],
        [2, 9],
        [3, 9],
        [4, 9],
        [5, 9],
        [6, 9],
        [7, 9],
        [8, 9],
        [9, 9]
      ].to_s
    end
  end
end
