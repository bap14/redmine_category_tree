module RedmineCategoryTree
	module Patches
		module QueriesHelperPatch
			include RedmineCategoryTree::IssueCategoryHelper

			def column_content(column, issue)
				if column.name == :category
					render_issue_category_with_tree(issue.category)
				else
					super
				end
			end
		end
	end
end
