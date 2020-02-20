class TimeFormatter 
  VALID_FORMATS = { 'year' => '%Y ',
                    'month' => '%m ',
                    'day' => '%d ',
                    'hour' => '%H ',
                    'minute' => '%M ',
                    'second' => '%S '
                  }

  def initialize(format_param)
    @wrong_format_types = []
    @format_string = ''
    format_keys_array = format_param.scan(/\b[a-zA-Z]+\b/)
    format_keys_array.each do |format_key|
      format_value = VALID_FORMATS[format_key]
      format_value ? @format_string.concat(format_value) : @wrong_format_types << format_key
    end
  end

  def time
    Time.now.strftime(@format_string)
  end

  def valid?
    @wrong_format_types.empty?
  end

  def invalid_formats
    'Unknown time format' + @wrong_format_types.to_s.gsub('"','')
  end
end
