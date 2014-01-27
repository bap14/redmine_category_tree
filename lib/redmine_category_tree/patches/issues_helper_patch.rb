module RedmineCategoryTree
	module Patches
		module IssuesHelperPatch
			def self.included(base)
				base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
				  unloadable
				  
				  include RedmineCategoryTree::IssueCategoryHelper

					alias_method_chain :find_name_by_reflection, :issue_categories unless method_defined?('find_name_by_reflection_without_issue_categories')
				end
			end

			module ClassMethods
			end

      module InstanceMethods
				def find_name_by_reflection_with_issue_categories(field, id)
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
  						return find_name_by_reflection_without_issue_categories(field, id)
  					end
  				else
  				  return find_name_by_reflection_without_issue_categories(field, id)
  				end
				end
			end
		end
	end
end
