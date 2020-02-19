class Router 
  def initialize(app)
    @app = app 
  end

  def call(env)
    @url = env['PATH_INFO']
    if valid_route?
      @app.call(env)
    else
      [
        404,
        { 'Content-type' => 'text/plain' },
        ['Invalid URL.']
      ]
    end
  end

  private

  def valid_route? 
    @url == '/time'
  end
end
