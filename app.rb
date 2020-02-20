require_relative 'time_formatter'

class App


  def call(env)
    @response = Rack::Response.new
    @request = Rack::Request.new(env)
    @response.headers['Content-type'] = 'text/plain'
    if @request['format']
      @response.body = generate_response_body
      @response.status = generate_response_status
    end
    @response.finish 
  end

  private
    
  BAD_REQUEST_STATUS = 400 
  OK_STATUS = 200

  def generate_response_body
    @formatter = TimeFormatter.new(@request['format'])
    if @formatter.valid?
      @formatter.time
    else 
      @formatter.invalid_formats
    end
  end

  # Сделал форматтер инстанс переменной чтобы сэкономить на вычислениях 
  def generate_response_status
    if @formatter.valid? 
      OK_STATUS
    else
      BAD_REQUEST_STATUS
    end
  end
end
