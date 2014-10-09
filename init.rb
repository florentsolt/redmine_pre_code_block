Redmine::Plugin.register :redmine_pre_code_block do
  name 'Redmine Pre Code Block plugin'
  author 'Florent Solt'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/florentsolt/redmine_pre_code_block'
  settings :default => {
  	'pre_code_block_javascript' => true,
  	'pre_code_block_html' => true,
  	'pre_code_block_css' => true,
  	'pre_code_block_ruby' => true,
  	'pre_code_block_erb' => true,
  	'pre_code_block_sql' => true
  	}, :partial => 'settings/pre_code_block'
end

module PreCodeBlock
	LANGUAGES = ["c", "cpp", "clojure", "css", "delphi", "diff", "erb", "groovy", "haml", "html", "java",
		"javascript", "json", "pascal", "php", "python", "ruby", "scheme", "sql", "xml", "yaml"]
end

module Redmine::WikiFormatting::Textile::Helper
  def heads_for_wiki_formatter_with_pre_code_block
    heads_for_wiki_formatter_without_pre_code_block
    unless @heads_for_wiki_formatter_with_pre_code_block_included
      content_for :header_tags do
      	("<script type='text/javascript'>var pre_code_block = " + PreCodeBlock::LANGUAGES.map do |lang|
      		Setting.plugin_redmine_pre_code_block['pre_code_block_' + lang.to_s] ? lang : nil
      	end.compact.to_json + ";</script>").html_safe +
        javascript_include_tag('jstoolbar', :plugin => 'redmine_pre_code_block')
      end
      @heads_for_wiki_formatter_with_pre_code_block_included = true
    end
  end

  alias_method_chain :heads_for_wiki_formatter, :pre_code_block
end

class PreCodeBlockViewListener < ::Redmine::Hook::ViewListener

  # Adds javascript and stylesheet tags
  def view_layouts_base_html_head(context)
    stylesheet_link_tag("pre_code_block.css", :plugin => "redmine_pre_code_block", :media => "screen")
  end

end
