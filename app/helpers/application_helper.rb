module ApplicationHelper
  
  def markdown file
    highlighter = Makeup::SyntaxHighlighter.new
    renderer = Makeup::Markup.new(:highlighter => highlighter)
    process_links(renderer.render(file,File.read(file)))
  end
  
  def process_links data
    data.sub /\[\[(.*)\]\]/ do |match|
      link_to $1, "/project/view/#{$1.downcase}"
    end
  end

end
