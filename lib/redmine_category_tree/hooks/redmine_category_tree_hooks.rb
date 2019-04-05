module RedmineCategoryTree
	module Hooks
		class RedmineCategoryTreeHooks < Redmine::Hook::ViewListener
			def view_layouts_base_html_head(context = {})
				stylesheet_link_tag 'redmine_category_tree.css', :plugin => 'redmine_category_tree'
			end
		end
	end
end
