describe Svgeez::Optimizer, '#optimize' do
  let(:logger) { Svgeez.logger }

  context 'when SVGO executable is not found' do
    let(:optimizer) { described_class.new }
    let(:warning_message) { 'Unable to find `svgo` in your PATH. Continuing with standard sprite generation...' }

    before do
      allow_any_instance_of(described_class).to receive(:installed?).and_return(nil)
    end

    it 'logs a warning' do
      expect(logger).to receive(:warn).with(warning_message)
      optimizer.optimize('<svg/>')
    end
  end

  context 'when SVGO executable is found' do
    context 'when SVGO version is not supported' do
      let(:optimizer) { described_class.new }
      let(:warning_message) { 'svgeez relies on SVGO 1.0.4 or newer. Continuing with standard sprite generation...' }

      before do
        allow_any_instance_of(described_class).to receive(:supported?).and_return(false)
      end

      it 'logs a warning' do
        expect(logger).to receive(:warn).with(warning_message)
        optimizer.optimize('<svg/>')
      end
    end

    context 'when SVGO version is supported' do
      let(:optimizer) { described_class.new }
      let(:input_file_contents) { IO.read('./spec/fixtures/icons/skull.svg') }
      let(:output_file_contents) { %(<svg id="skull" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="32" height="32" fill="currentcolor"><path d="M16 0C6 0 2 4 2 14v8l4 2v6h20v-6l4-2v-8C30 4 26 0 16 0M9 12a4.5 4.5 0 0 1 0 9 4.5 4.5 0 0 1 0-9m14 0a4.5 4.5 0 0 1 0 9 4.5 4.5 0 0 1 0-9"/></svg>\n) }

      it 'returns a string' do
        expect(optimizer.optimize(input_file_contents)).to eq(output_file_contents)
      end
    end
  end
end
