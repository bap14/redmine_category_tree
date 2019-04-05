module RedmineCategoryTree
  module Patches
    module ContextMenusControllerPatch
      def self.included(base) # :nodoc:
        base.class_eval do
          helper RedmineCategoryTree::IssueCategoryHelper
        end
      end
    end
  end
end