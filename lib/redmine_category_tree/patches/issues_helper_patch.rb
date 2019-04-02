module RedmineCategoryTree
	module Patches
		module IssuesHelperPatch
			def self.included(base)
				base.class_eval do
				  unloadable
				  include RedmineCategoryTree::IssueCategoryHelper
					base.prepend(FindNameByReflectionPatch)
				end
			end
		end
		module FindNameByReflectionPatch
			def find_name_by_reflection(field, id)
				unless id.present?
					return nil
				end
				if field == 'category'
					association = Issue.reflect_on_association(field.to_sym)
					if association
						record = association.class_name.constantize.find_by_id(id)
						if record
							return render_issue_category_with_tree_inline(record)
						end
					else
						return super(field, id)
					end
				else
					return super(field, id)
				end
			end
		end
	end
end
