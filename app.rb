class App
  VALID_FORMATS = { 'year' => '%Y ',
                    'month' => '%m ',
                    'day' => '%d ',
                    'hour' => '%H ',
                    'minute' => '%M ',
                    'second' => '%S '
                  }
  BAD_REQUEST_STATUS = 400 

  def call(env)
    @response = Rack::Response.new
    @request = Rack::Request.new(env)
    @response.headers['Content-type'] = 'text/plain'
    if @request['format']
      @response.body << generate_formatted_time(@request['format'])
    else
      @response.status = BAD_REQUEST_STATUS
    end
    @response.finish 
  end

  private

  def generate_formatted_time(format_param)
    wrong_format_types = []
    format_string = ''
    # Grabbing whole words from query string without delimiters 
    format_keys_array = format_param.scan(/\b[a-zA-Z]+\b/)
    format_keys_array.each do |format_key|
      format_value = VALID_FORMATS[format_key]
      format_value ? format_string.concat(format_value) : wrong_format_types << format_key
    end
    if wrong_format_types.empty?
      # Не придумал как сделать нормальные сепараторы для формата не усложняя код 
      Time.now.strftime(format_string)
    else
    # Насколько приемлимо задавать статус ответа в этом месте ? 
      @response.status = BAD_REQUEST_STATUS
      'Unknown time format' + wrong_format_types.to_s.gsub('"','')
    end
  end
end
