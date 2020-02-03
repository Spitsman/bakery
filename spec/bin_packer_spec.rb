require '../lib/bin_packer'

describe BinPacker do
  describe '.call' do
    context 'when it is not possible to calculate bin packing' do
      it 'calculates bin packing' do
        expect(subject.call(10, [3, 5])).to eq [{5 => 2}]
        expect(subject.call(14, [2, 5, 8])).to eq [{5 => 2, 2 => 2}, { 8 => 1, 2 => 3}]
        expect(subject.call(10, [3, 5])).to eq [{5 => 2}]
      end
    end

    context 'when it is impossible to calculate bin packing' do
      it 'returns an empty array' do
        expect(subject.call(20, [11, 12])).to eq []
      end
    end
  end
end
