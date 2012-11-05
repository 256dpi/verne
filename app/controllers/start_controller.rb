class StartController < ApplicationController
  
  def index
    @old_path = session[:path] || ""
  end

end