module SrtParser2
  class Line
    attr_accessor :sequence, :error

    attr_writer :start_time, :end_time

    def empty?
      sequence.nil? && start_time.nil? && end_time.nil? && text == '' && error.nil?
    end

    def filled?
      sequence.is_a?(Integer) && start_time.is_a?(Integer) && end_time.is_a?(Integer) && error.nil?
    end

    def start_time
      to_i(@start_time)
    end

    def end_time
      to_i(@end_time)
    end

    def next_sequence
      raise 'invalid impliment!!!!!!!' if sequence.nil?
      sequence + 1
    end

    def text
      @text ||= ''
    end

    private

    def to_i(time_str)
      return nil if time_str.nil?

      hours, minutes, seconds_and_millis = time_str.split(':')
      seconds, millis = seconds_and_millis.split(',')

      total_seconds =
        hours.to_i * 3600 +
        minutes.to_i * 60 +
        seconds.to_i +
        (millis.to_f / 1000)

      total_seconds.to_i
    end
  end
end
