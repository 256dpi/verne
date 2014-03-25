module Kramdown
  module Converter
    class Pygs < Html
      def convert_codeblock(el, indent)
        attr = el.attr.dup
        lang = extract_code_language!(attr)
        if lang
          add_code_tags Pygments.highlight(el.value, lexer: lang, options: { encoding: 'utf-8' })
        else
          "<pre><code>#{el.value}</code></pre>"
        end
      end

      def add_code_tags(code)
        code = code.sub(/<pre>/, '<pre><code>')
        code = code.sub(/<\/pre>/, '</code></pre>')
      end
    end
  end
end

module ApplicationHelper
  
  def markdown file
    content = File.read(file)
    content = process_iframes(content)
    content = convert_backticks(content)
    content = Kramdown::Document.new(content).to_pygs
    content = process_links(content)
    content = process_images(content)
    content
  end

  def process_iframes data
    data.gsub! /\<\<\<(.*)\>\>\>/ do |match|
      "<iframe class=\"expanded\" src=\"/file/#{params[:wiki_id]}/#{$1}\"></iframe>"
    end
    data.gsub /\<\<(.*)\>\>/ do |match|
      "<iframe src=\"/file/#{params[:wiki_id]}/#{$1}\"></iframe>"
    end
  end

  def convert_backticks data
    data.gsub(/```/, '~~~') || data
  end
  
  def process_links data
    data.gsub /\[\[(.*)\]\]/ do |match|
      link_to $1, "/view/#{params[:wiki_id]}/#{$1.downcase.parameterize}"
    end
  end
  
  def process_images data
    data.gsub /<img src="(.+?)"(.*)>/i do |match|
      "<img src=\"/file/#{params[:wiki_id]}/#{$1}\" #{$2}>"
    end
  end
  
  def files_tree path
    files = []
    Dir["#{path}/*.md"].each do |file|
      files.push file.gsub("#{@path}/", '').gsub('.md', '')
    end
    files - ['index']
  end

end
