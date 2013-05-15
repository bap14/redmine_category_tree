module RedmineCategoryTree
	module IssueCategoryHelper
		def issue_category_tree_options_for_select(issue_categories, options={})
			s = ''
			issue_category_tree(issue_categories) do |category, level|
				if category.id.nil?
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

		def issue_category_tree(issue_categories, &block)
			IssueCategory.issue_category_tree(issue_categories, &block)
		end

		def render_issue_category_with_tree(category)
      return '' if category.nil?
			s = ''
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
