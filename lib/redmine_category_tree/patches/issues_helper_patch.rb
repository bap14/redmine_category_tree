module RedmineCategoryTree
	module Patches
		module IssuesHelperPatch
			def self.prepended(base)
				base.class_eval do
				  include RedmineCategoryTree::IssueCategoryHelper
				end
			end

			def find_name_by_reflection(field, id)
				unless id.present?
					return nil
				end
				if field == 'category'
					@detail_value_name_by_reflection ||= Hash.new do |hash, key|
						association = Issue.reflect_on_association(field.to_sym)
						if association
							record = association.klass.find_by_id(id)
							if record
								Rails.logger.info "  - Yes, generating tree inline"
								hash[key] = render_issue_category_with_tree_inline(record).force_encoding('UTF-8')
							end
						end
					end
					super(field, id) unless @detail_value_name_by_reflection[[field, id]]
				else
					super(field, id)
				end
			end
		end
	end
end
