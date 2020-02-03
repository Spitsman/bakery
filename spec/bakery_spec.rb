require '../lib/bakery'

describe Bakery do
  subject { described_class.new('../config/products.yml') }

  describe '.pack' do
    context 'when product with the given code exists' do
      let(:count) { 14 }
      let(:code) { 'MB11' }
      it 'returns variants of order package' do
        expect(subject.pack(count, code)).to eq [{{'price' => 16.95, 'count' => 5} => 2, {'price' => 9.95, 'count' => 2} => 2},
                                                 {{'price' => 24.95, 'count' => 8} => 1, {'price' => 9.95, 'count' => 2} => 3}]
      end
    end

    context 'when product with the given code does not exist' do
      let(:count) { 5 }
      let(:code) { 'sadf' }
      it 'raises an exception' do
        expect { subject.pack(count, code) }.to raise_exception(Bakery::ProductNotFoundError, 'Product not found')
      end
    end

    context 'when it is impossible to pack order' do
      let(:count) { 11 }
      let(:code) { 'VS5' }
      it 'raises an exception' do
        expect { subject.pack(count, code) }.to raise_exception(Bakery::PackError, "Unable to create pack of 11 items for Vegemite Scroll")
      end
    end
  end
end
