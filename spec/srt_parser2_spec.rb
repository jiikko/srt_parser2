# frozen_string_literal: true

RSpec.describe SrtParser2 do
  it 'has a version number' do
    expect(SrtParser2::VERSION).not_to be nil
  end

  describe '.parse' do
    subject { SrtParser2.parse(srt_body) }

    context 'with normal.srt' do
      let(:srt_body) { File.read('spec/fixtures/normal.srt') }

      it 'return lines' do
        expect(subject.lines[0]).to have_attributes(sequence: 1, start_time: 235.339, end_time: 237.236,
                                                    text: ['I had the craziest dream last night.'])
        expect(subject.lines[1]).to have_attributes(sequence: 2, start_time: 239.679, end_time: 241.586,
                                                    text: ['I was dancing the White Swan.'])
        expect(subject.lines.size).to eq 2
      end
    end

    context 'with include_empty.srt' do
      let(:srt_body) { File.read('spec/fixtures/include_empty.srt') }

      it 'return lines' do
        expect(subject.lines[0]).to have_attributes(sequence: 1, text: ['[音楽]'])
        expect(subject.lines[1]).to have_attributes(sequence: 2, text: [])
        expect(subject.lines[2]).to have_attributes(sequence: 3, text: ['ん'])
        expect(subject.lines.size).to eq 3
      end
    end
  end
end
