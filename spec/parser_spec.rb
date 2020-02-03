require '../lib/parser'

describe Parser do
  subject { described_class }

  describe '#call' do
    context 'when line is valid' do
      let(:line) { '10 CF' }
      it 'parses line' do
        expect(subject.call(line)).to eq([10, 'CF'])
      end
    end

    context 'when line is invalid' do
      let(:line) { 'asd234f' }
      it 'raises an exception' do
        expect { subject.call(line) }.to raise_exception(Parser::WrongInputError, 'Wrong input')
      end
    end
  end
end
