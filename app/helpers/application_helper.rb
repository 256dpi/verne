module ApplicationHelper
  
  def markdown file
    highlighter = Makeup::SyntaxHighlighter.new
    renderer = Makeup::Markup.new(:highlighter => highlighter)
    text = process_links(renderer.render(file,File.read(file)))
    process_images(text)
  end
  
  def process_links data
    data.gsub /\[\[(.*)\]\]/ do |match|
      link_to $1, "/project/view/#{$1.downcase.parameterize}"
    end
  end
  
  def process_images data
    data.gsub /<img src="(.+?)"(.*)>/i do |match|
      "<img src=\"/project/file/#{$1}\" #{$2}>"
    end
  end
  
  def files_tree
    files = []
    Dir[session[:path]+"/**/*.md"].each do |file|
      files.push file.gsub(session[:path]+"/","").gsub(".md","")
    end
    files - ["index"]
  end

end
