module RedmineCategoryTree
	module Patches
		module QueriesHelperPatch
			def self.included(base)
				base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
					unloadable

					alias_method_chain :column_content, :issue_categories
				end
			end

			module ClassMethods
			end

			module InstanceMethods
				def column_content_with_issue_categories(column, issue)
					if column.name == :category
						render_issue_category_with_tree(issue.category)
					else
						column_content_without_issue_categories(column, issue)
					end
				end
			end
		end
	end
end
