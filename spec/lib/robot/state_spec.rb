require_relative '../../spec_helper'

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

  describe '#move' do
    before do
      state.place(1, 1, direction)
    end

    # On a 3x3 board, only 1 step is allowed in any direction
    let(:size) { 3 }

    context 'when moving up' do
      let(:direction) { 'NORTH' }

      it 'moves until the edge' do
        expect { state.move }.to change { state.position }.from([1, 1]).to([1, 2])
        expect { state.move }.to raise_exception Robot::StateException
      end
    end
    context 'when moving down' do
      let(:direction) { 'SOUTH' }

      it 'moves until the edge' do
        expect { state.move }.to change { state.position }.from([1, 1]).to([1, 0])
        expect { state.move }.to raise_exception Robot::StateException
      end
    end
    context 'when moving left' do
      let(:direction) { 'EAST' }

      it 'moves until the edge' do
        expect { state.move }.to change { state.position }.from([1, 1]).to([0, 1])
        expect { state.move }.to raise_exception Robot::StateException
      end
    end
    context 'when moving right' do
      let(:direction) { 'WEST' }

      it 'moves until the egde' do
        expect { state.move }.to change { state.position }.from([1, 1]).to([2, 1])
        expect { state.move }.to raise_exception Robot::StateException
      end
    end
  end
end
