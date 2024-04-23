# frozen_string_literal: true

require_relative 'srt_parser2/line'
require_relative 'srt_parser2/version'

module SrtParser2
  STOP_WORD = 'endfile!!!!!!!!!!!!!!!!!!!!!'
  class Result
    def lines
      @lines ||= []
    end
  end

  # @praam srt_body [String]
  def self.parse(srt_body)
    parse_string(srt_body)
  end

  def self.parse_string(srt_data)
    result = Result.new
    line = Line.new

    split_srt_data(srt_data).each_with_index do |str, index|
      if line.error.nil?
        if line.sequence.nil?
          line.sequence = str.to_i
        elsif line.start_time.nil?
          if (mres = str.match(/(?<start_timecode>[^[[:space:]]]+) -+> (?<end_timecode>[^[[:space:]]]+) ?/))

            if (line.start_time = mres['start_timecode']).nil?
              line.error = "#{index}, Invalid formatting of start timecode, [#{mres['start_timecode']}]"
              warn line.error if @debug
            end

            if (line.end_time = mres['end_timecode']).nil?
              line.error = "#{index}, Invalid formatting of end timecode, [#{mres['end_timecode']}]"
              warn line.error if @debug
            end
          else
            line.error = "#{index}, Invalid Time Line formatting, [#{str}]"
            warn line.error if @debug
          end
        elsif line.filled? && str == line.next_sequence.to_s
          result.lines << line
          line = Line.new
          line.sequence = str.to_i
        elsif str == STOP_WORD
          result.lines << line
        else
          line.text << str.strip if str.strip.length.positive?
        end
      end
    rescue StandardError
      line.error = "#{index}, General Error, [#{str}]"
      warn line.error if @debug
    end
    result
  end

  def self.split_srt_data(srt_data)
    srt_data.split(/\n/) + ["\n"] + [STOP_WORD]
  end
end
