class ProjectController < ApplicationController
  
  def view
    if session.has_key? :path
      @file = params[:file]+".md"
      @file_full = session[:path]+"/"+@file
      if not File.file? @file_full
        redirect_to "/project/edit/#{params[:file]}"
      end
    else
      redirect_to root_url
    end
  end
  
  def edit
    if session.has_key? :path
      @file = params[:file]
      @file_full = session[:path]+"/"+@file+".md"
      if File.file? @file_full
        @content = File.read(@file_full)
      else
        @content = ""
      end
    else
      redirect_to root_url
    end
  end
  
  def save
    if session.has_key? :path
      @file = params[:file]+".md"
      @file_full = session[:path]+"/"+@file
      @code = params[:code] || ""
      @code = @code.gsub("\t","  ")
      `mkdir -p #{File.dirname(@file_full)}`
      File.open(@file_full,"w") {|f| f.write(@code) }
      redirect_to "/project/view/#{params[:file]}"
    else
      redirect_to root_url
    end
  end
  
  def open
    path = params[:path]
    if File.directory? path
      session[:path] = path
      redirect_to "/project/view/index"
    else
      render :text => "Not a directory!", :status => 404
    end
  end

end