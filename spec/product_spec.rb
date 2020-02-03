require '../lib/product'

describe Product do
  let(:pack1) { {'price' => 10, 'count' => 2} }
  let(:pack2) { {'price' => 15, 'count' => 3} }
  let(:packs) { [pack1, pack2] }
  let(:product) { described_class.new(name: 'name', code: 'code', packs: packs) }

  describe '.name' do
    subject { product.name }
    it { is_expected.to eq('name') }
  end

  describe '.code' do
    subject { product.code }
    it { is_expected.to eq('code') }
  end

  describe '.packs' do
    subject { product.packs }
    it { is_expected.to eq(packs) }
  end

  describe '.packs_counts' do
    subject { product.packs_counts }
    it { is_expected.to eq([2, 3]) }
  end

  describe '.find_pack' do
    subject { product.find_pack('count', 2) }
    it { is_expected.to eq pack1 }
  end
end
