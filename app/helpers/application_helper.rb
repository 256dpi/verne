module ApplicationHelper
  
  def markdown file
    highlighter = Makeup::SyntaxHighlighter.new
    renderer = Makeup::Markup.new(:highlighter => highlighter)
    text = process_links(renderer.render(file,File.read(file)))
    process_images(text)
  end
  
  def process_links data
    data.sub /\[\[(.*)\]\]/ do |match|
      link_to $1, "/project/view/#{$1.downcase}"
    end
  end
  
  def process_images data
    data.gsub /<img src="(.+?)"(.*)>/i do |match|
      file = File.dirname(@file_full)+"/"+$1
      url = "data:image/#{File.extname($1)};base64,#{Base64.encode64(File.read(file))}"
      "<img src=\"#{url}\" #{$2}>"
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
