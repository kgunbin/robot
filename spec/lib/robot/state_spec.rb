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

  describe '#turn' do
    before do
      state.place(0, 0, 'NORTH')
    end

    context 'when turning right' do
      let(:left) { false }

      it 'changes the rotation correctly' do
        expect { state.turn(left) }.to change { state.direction }.to('EAST')
        expect { state.turn(left) }.to change { state.direction }.to('SOUTH')
        expect { state.turn(left) }.to change { state.direction }.to('WEST')
        expect { state.turn(left) }.to change { state.direction }.to('NORTH')
      end
    end

    context 'when turning left' do
      let(:left) { true }

      it 'changes the rotation correctly' do
        expect { state.turn(left) }.to change { state.direction }.to('WEST')
        expect { state.turn(left) }.to change { state.direction }.to('SOUTH')
        expect { state.turn(left) }.to change { state.direction }.to('EAST')
        expect { state.turn(left) }.to change { state.direction }.to('NORTH')
      end
    end
  end
end
