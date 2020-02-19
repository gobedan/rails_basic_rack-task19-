require_relative 'app'
require_relative 'router'

use Router
run App.new
