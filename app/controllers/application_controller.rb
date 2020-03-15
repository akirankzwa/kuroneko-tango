class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "akira", password: "secret"
end
