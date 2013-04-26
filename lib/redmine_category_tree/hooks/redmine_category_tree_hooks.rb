module RedmineCategoryTree
	module Hooks
		class RedmineCategoryTreeHooks < Redmine::Hook::ViewListener
			def view_layouts_base_html_head(context = {})
				css = stylesheet_link_tag 'redmine_category_tree.css', :plugin => 'redmine_category_tree'

				css
			end

			def helper_issues_show_detail_after_setting(context = {})
				# if context[:detail].property == 'attr' && context[:detail].prop_key == 'category_id'
				#	if !context[:detail].old_value.blank?
				#		oldCategory = IssueCategory.find(context[:detail].old_value)
				#		context[:detail].old_value = IssueCategory.render_issue_category_with_tree_inline(oldCategory)
				#	end

				#	if !context[:detail].value.blank?
				#		newCategory = IssueCategory.find(context[:detail].value)
				#		context[:detail].value = IssueCategory.render_issue_category_with_tree_inline(newCategory)
				#	end
				# end
			end
		end
	end
end
