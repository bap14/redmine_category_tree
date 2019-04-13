module RedmineCategoryTree
  module IssueCategoryHelper
    include ERB::Util
    include ActionView::Helpers::TagHelper

    def issue_category_tree_options_for_select(issue_categories, options={})
      s = ''
      issue_category_tree(issue_categories) do |category, level|
        if category.nil? || category.id.nil?
          next
        end

        name_prefix = (level > 0 ? '|&nbsp;&nbsp;' * level + '&#8627; ' : '')
        if name_prefix.length > 0
          name_prefix = name_prefix.slice(1, name_prefix.length)
        end
        name_prefix = name_prefix.html_safe
        tag_options = { :value => category.id }
        if !options[:selected].nil? && category.id == options[:selected]
          tag_options[:selected] = 'selected'
        else
          tag_options[:selected] = nil
        end

        if !options[:current].nil? && options[:current].id == category.id
          tag_options[:disabled] = 'disabled'
        end

        tag_options.merge!(yield(category)) if block_given?
        s << tag.option(tag_options) do
          name_prefix + h(category)
        end
      end
      s.html_safe
    end

    def issue_category_tree_options_for_json(issue_categories, options={})
      s = issue_category_tree_options_to_json(issue_categories, options)
      ActiveSupport::JSON.encode(s)
    end

    def issue_category_tree_options_to_json(issue_categories, options={})
      s = []
      issue_category_tree(issue_categories) do |category, level|
        if category.nil? || category.id.nil?
          next
        end

        name_prefix = (level > 0 ? '|' + ("|-" * level) + '> ' : '')
        if name_prefix.length > 0
          name_prefix = name_prefix.slice(1, name_prefix.length)
        end

        s << [ name_prefix + category.name, category.id.to_s ]
      end
      s
    end

    def issue_category_tree(issue_categories, &block)
      IssueCategory.issue_category_tree(issue_categories, &block)
    end
    
    def render_issue_category_tree_list(categories, includeOuterUL=false, &block)
      categories = issue_category_tree(categories) { |cat, level| nil }
      return '' if categories.size == 0
      
      output = ''
      output << '<ul>' if includeOuterUL
      output << '<li>'
      
      path = [nil]
      
      categories.each_with_index do |cat, idx|
        if cat.parent_id != path.last
          if path.include?(cat.parent_id)
            while path.last != cat.parent_id
              path.pop
              output << '</li></ul>'
            end
            output << '</li><li>'
          else
            path << cat.parent_id
            output << '<ul><li>'
          end
        elsif idx != 0
          output << '</li><li>'  
        end
        output << capture(cat, path.size - 1, &block)
      end
      
      output << '</li><ul>' * (path.length - 1)
      output << '</ul>' if includeOuterUL
      output.html_safe
    end
    
    def render_issue_category_tree_context_menu_list(categories, includeOuterUL=false, &block)
      categories = issue_category_tree(categories) { |cat, level| {} }
      return '' if categories.size == 0
      
      output = ''
      output << '<ul>' if includeOuterUL
      
      path = [nil]
      
      categories.each_with_index do |cat, idx|
        if cat.parent_id != path.last
          if path.include?(cat.parent_id)
            while path.last != cat.parent_id
              path.pop
              output << '</ul></li>'
            end
          else
            path << cat.parent_id
            output << '<li class="category-tree-nofx"><ul>'
          end
        end
#
        output << '<li>' + capture(cat, path.size - 1, &block) + '</li>'
      end

      output << '</ul></li>' * (path.length - 1) if path.length

      output << '</ul>' if includeOuterUL

      output.html_safe
    end

    def render_issue_category_with_tree(category)
      s = ''
      if category.nil?
        return ''
      end
      ancestors = category.root? ? [] : category.ancestors.all
      if ancestors.any?
        s << '<ul id="issue_category_tree">'
        ancestors.each do |ancestor|
          s << '<li>' + tag.span(h(ancestor.name)) + '<ul>'
        end
        s << '<li>'
      end

      s << tag.span(h(category.name), :class => 'issue_category')

      if ancestors.any?
        s << '</li></ul>' * (ancestors.size + 1)
      end
      s.html_safe
    end
    
    def render_issue_category_with_tree_inline(category)
      s = ''
      if category.nil?
        return ''
      end
      ancestors = category.root? ? [] : category.ancestors.all
      if ancestors.any?
        ancestors.each do |ancestor|
          s << tag.span(h(ancestor.name), :class => 'parent')
        end
      end

      s << tag.span(h(category.name), :class => 'issue_category')
      
      if ancestors.any?
        s = tag.span(s.html_safe, :class => 'issue_category_tree')
      end
      s.html_safe
    end
    
    def move_category_path(category, direction)
      url_for({ :controller => 'issue_categories', :action => 'move_category', :id => category.id, :direction => direction })
    end
  end
end
