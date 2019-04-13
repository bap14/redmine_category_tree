module RedmineCategoryTree
  module Patches
    module IssueQueryPatch
      def self.prepended(base)
        base.class_eval do
          include RedmineCategoryTree::IssueCategoryHelper
        end
      end

      def initialize_available_filters
        super
        add_available_filter "category_id",
           :type => :list_optional,
           :values => lambda { issue_category_tree_options_to_json(project.issue_categories) } if project
      end
    end
  end
end