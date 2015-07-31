module RedmineCategoryTree
  module IssueCategoryHelper
    def issue_category_tree_options_for_select(issue_categories, options={})
      s = ''
      issue_category_tree(issue_categories, true) do |category, level|
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
        s << content_tag('option', name_prefix + h(category), tag_options)
				
      end
      s.html_safe
    end

    def issue_category_tree(issue_categories, ignore_disabled = false, &block)
	
	  if ignore_disabled
	  
		cats   = []
		levels = []
	  
	    cur_disabled_levels = []
	    IssueCategory.issue_category_tree(issue_categories) do |category, level|
		
		  # Child levels no longer matter if we moved up
		  while !cur_disabled_levels.empty? && cur_disabled_levels.last >= level
		    cur_disabled_levels.pop
		  end
		
	  	  has_disabled_parent_cat   = !cur_disabled_levels.empty? && cur_disabled_levels.min < level
		  disabled_at_current_level = !cur_disabled_levels.empty? && cur_disabled_levels.last == level
		  current_cat_disabled      = category.archived || has_disabled_parent_cat
		  
		  # If archived here, current disabled level
		  if category.archived
		    cur_disabled_levels.push level
		  # Pop current level if reached again, but honor setting from parent for this one
		  elsif disabled_at_current_level
		    while !cur_disabled_levels.empty? && cur_disabled_levels.last == level
		      cur_disabled_levels.pop
		    end
		  end

		  if !current_cat_disabled
		    cats.push category
			levels.push level
		  end
		  	  
		end

        if !cats.nil?
		  # How to make a normal for loop?? => for(int i = 0; i < cats.size(); ++i) { ... } ???
		  len = cats.size - 1
		  (0..len).each do |i|
		    yield cats[i], levels[i]
		  end
		end
		return cats
	  else
	    IssueCategory.issue_category_tree(issue_categories, &block)
	  end
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
      categories = issue_category_tree(categories, true) { |cat, level| nil }
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
        output << '<li>'
        output << capture(cat, path.size - 1, &block)
        output << '</li>'
      end
      
      output << '</ul></li>' * (path.length - 1)
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
          s << '<li>' + content_tag('span', h(ancestor.name)) + '<ul>'
        end
        s << '<li>'
      end

      s << content_tag('span', h(category.name), :class => 'issue_category')

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
          s << content_tag('span', h(ancestor.name), :class => 'parent')
        end
      end

      s << content_tag('span', h(category.name), :class => 'issue_category')
      
      if ancestors.any?
        s = content_tag('span', s, { :class => 'issue_category_tree' }, false)
      end
      s.html_safe
    end
    
    def move_category_path(category, direction)
      url_for({ :controller => 'issue_categories', :action => 'move_category', :id => category.id, :direction => direction })
    end
  end
end
