require 'mime-types'

class WikiController < ApplicationController

  def index
    if !@projects.empty?
      id = @projects.keys.first
      redirect_to "/view/#{id}/index"
    else
      raise 'no projects found in ~/.verne.json'
    end
  end

  def view
    get_info
    if not File.exists? @file
      redirect_to "/edit/#{@id}/#{@page}"
    end
  end

  def edit
    get_info
    if File.exists? @file
      @content = File.read(@file)
    else
      @content = ''
    end
  end

  def delete
    get_info
    if File.exists? @file
      File.delete(@file)
    end
    redirect_to "/view/#{@id}/index"
  end

  def save
    get_info
    @code = params[:code] || ''
    @code = @code.gsub("\t",'  ')
    File.open(@file, 'w') {|f| f.write(@code) }
    redirect_to "/view/#{@id}/#{@page}"
  end

  def file
    get_info
    @file = File.expand_path("#{@project['path']}/#{params[:file]}")
    if File.exists? @file
      @mime = MIME::Types.of(@file)
      @type = @mime.count > 0 ? @mime.first.content_type : ''
      if @type.match /image/
        send_file @file, disposition: :inline, type: @type, x_sendfile: true
      else
        render file: @file, content_type: @type, layout: false
      end
    end
  end

  def get_info
    if @projects[params[:wiki_id]].present?
      @project = @projects[params[:wiki_id]]
      @id = params[:wiki_id]
      @name = @projects[@id]['name']
      @page = params[:page]
      @path = @projects[@id]['path']
      @file = File.expand_path("#{@project['path']}/#{params[:page]}.md")
      @text = File.read(@file) if File.exists?(@file)
    else
      raise 'wiki not found'
    end
  end

end
