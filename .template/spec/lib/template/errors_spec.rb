RSpec.describe Template::Errors do
  describe '#add' do
    it 'adds the error message to the array of errors' do
      subject.add('Cannot create a file')

      expect(subject.send(:errors)).to eq(['Cannot create a file'])
    end
  end

  describe '#empty?' do
    context 'when there are any error messages' do
      it 'returns false' do
        subject.add('Cannot create a file')

        expect(subject.empty?).to eq(false)
      end
    end

    context 'when there is NO error message' do
      it 'returns true' do
        expect(subject.empty?).to eq(true)
      end
    end
  end

  describe '#to_s' do
    context 'when there are any error messages' do
      it 'returns the formatted error message' do
        subject.add('Cannot create a file')
        subject.add('Cannot create a directory')

        expect(subject.to_s).to eq("Cannot create a file#{'-' * 80}\nCannot create a directory")
      end
    end

    context 'when there is NO error message' do
      it 'returns an empty string' do
        expect(subject.to_s).to eq('')
      end
    end
  end
end
