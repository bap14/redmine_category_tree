require File.dirname(__FILE__) + '/../../../app/views/helpers/redmine_category_tree/issue_category_helper.rb'

module RedmineCategoryTree
	module Patches
		module IssuesControllerPatch
			def self.included(base) # :nodoc:
				base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
					unloadable

					helper RedmineCategoryTree::IssueCategoryHelper
				end
			end

			module ClassMethods
			end

			module InstanceMethods
			end
		end
	end
end
