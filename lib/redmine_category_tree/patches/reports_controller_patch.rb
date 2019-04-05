module RedmineCategoryTree
  module Patches
    module ReportsControllerPatch
      def self.prepended(base)
        base.class_eval do
          helper RedmineCategoryTree::IssueCategoryHelper
        end
      end
    end
  end
end
