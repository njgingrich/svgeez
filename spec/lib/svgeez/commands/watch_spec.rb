require 'mercenary'

describe Svgeez::Commands::Watch do
  let(:program) { Mercenary::Program.new(:svgeez) }

  let(:command) { Svgeez::Commands::Watch.init_with_program(program) }

  it 'sets a description' do
    expect(command.description).to eq('Watches a folder of SVG icons for changes')
  end

  it 'sets a syntax' do
    expect(command.syntax).to eq('svgeez watch [options]')
  end
end
