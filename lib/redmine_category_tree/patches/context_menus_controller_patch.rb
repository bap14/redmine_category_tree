require File.dirname(__FILE__) + '/../../../app/views/helpers/redmine_category_tree/issue_category_helper.rb'

module RedmineCategoryTree
  module Patches
    module ContextMenusControllerPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          unloadable

          helper RedmineCategoryTree::IssueCategoryHelper
        end
      end
    end
  end
end