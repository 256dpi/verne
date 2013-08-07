class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :load_config

  def load_config
    file = File.expand_path("~/.verne.json")
    if File.exists? file
      @projects = JSON.parse(File.read(file))["projects"]
    else
      @projects = {}
    end

  end
  
end
