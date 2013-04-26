module RedmineCategoryTree
	module Hooks
		class RedmineCategoryTreeHooks < Redmine::Hook::ViewListener
			def view_layouts_base_html_head(context = {})
				css = stylesheet_link_tag 'redmine_category_tree.css', :plugin => 'redmine_category_tree'

				css
			end
		end
	end
end
