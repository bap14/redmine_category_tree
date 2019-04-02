module RedmineCategoryTree
	module Patches
		module QueriesHelperPatch
			def column_content(column, issue)
				if column.name == :category
					render_issue_category_with_tree(issue.category)
				else
					super(column, issue)
				end
			end
		end
	end
end
