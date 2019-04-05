module RedmineCategoryTree
	module Patches
		module IssuesControllerPatch
			def self.prepended(base)
				base.class_eval do
					helper RedmineCategoryTree::IssueCategoryHelper
				end
			end
		end
	end
end
