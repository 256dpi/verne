module ApplicationHelper
  
  def markdown file
    content = File.read(file)
    content = process_iframes(content)
    highlighter = Makeup::SyntaxHighlighter.new
    renderer = Makeup::Markup.new(:highlighter => highlighter)
    text = process_links(renderer.render(file,content))
    process_images(text)
  end

  def process_iframes data
    data.gsub! /\<\<\<(.*)\>\>\>/ do |match|
      "<iframe class=\"expanded\" src=\"/file/#{params[:wiki_id]}/#{$1}\"></iframe>"
    end
    data.gsub /\<\<(.*)\>\>/ do |match|
      "<iframe src=\"/file/#{params[:wiki_id]}/#{$1}\"></iframe>"
    end
  end
  
  def process_links data
    data.gsub /\[\[(.*)\]\]/ do |match|
      link_to $1, "/file/#{params[:wiki_id]}/#{$1.downcase.parameterize}"
    end
  end
  
  def process_images data
    data.gsub /<img src="(.+?)"(.*)>/i do |match|
      "<img src=\"/file/#{params[:wiki_id]}/#{$1}\" #{$2}>"
    end
  end
  
  def files_tree path
    files = []
    Dir[path+"/*.md"].each do |file|
      files.push file.gsub(@path+"/","").gsub(".md","")
    end
    files - ["index"]
  end

end
