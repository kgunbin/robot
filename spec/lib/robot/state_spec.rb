require_relative '../../../lib/robot/state'

describe Robot::State do
  let(:size) { 5 }
  let(:state) { described_class.new(size) }

  describe '#place' do
    subject(:place) { state.place(x, y, d) }

    let(:x) { 3 }
    let(:y) { 2 }
    let(:d) { 'NORTH' }

    context 'happy path' do
      it { is_expected.to be_nil }
    end
  end
end
