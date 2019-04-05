module RedmineCategoryTree
	module Patches
		module QueriesHelperPatch
			#def self.prepended(base) # :nodoc:
				#base.send :include, RedmineCategoryTree::IssueCategoryHelper
				#base.class_eval do
					include RedmineCategoryTree::IssueCategoryHelper
				#end
			#end

			def column_content(column, issue)
				Rails.logger.info "-----] Show me the category! [-----"
				if column.name == :category
					render_issue_category_with_tree(issue.category)
				else
					super
				end
			end
		end
	end
end
