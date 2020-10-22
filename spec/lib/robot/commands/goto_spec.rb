require_relative '../../../spec_helper'
require_relative '../../../../lib/robot'

describe Robot::Commands::GoTo do
  before { state.place(0, 0, 'EAST') }

  context 'when finding its way in the field with obstacles' do
    let(:state) do
      Robot::State.new(10, [[1, 1], [5, 6], [7, 0], [8, 7]])
    end

    subject(:goto) { described_class.new.execute_command(state, '9,9') }

    it 'gets to the finish' do
      expect(goto).to eq [1,2]
    end
  end
end
