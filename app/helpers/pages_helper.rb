module PagesHelper
  def render_tree(root_page)
    @tree = []
    root_page.map do |page|
      if page.has_children?
        child_tree(page.hash_tree)
      else
        @tree << "<br>"
        @tree << link_to(page.name, page.name)
      end
    end
    sanitize @tree.join
  end

  def child_tree(hashtree, indent = 0)
    hashtree.map do |ancestor, child|
      @tree << "&nbsp;" * indent
      @tree << link_to(ancestor.name, ancestor.build_name)
      @tree << "<br>"
      child_tree(child, indent + 2) if child.is_a?(Hash) && !child.empty?
    end
  end

  def normalizing_content(text)
    text.gsub!(/\*\[([\wа-яА-я]+)\]\*/) { "<b>#{$1}</b>" }
    text.gsub!(/\\\[([\wа-яА-Я]+)\]\\/) { "<i>#{$1}</i>" }
    text.gsub!(/\(\(([^\]]+) \[([^\]]+)\]\)\)/) { "<a href=#{$1}>#{$2}</a>" }
    text
  end
end
