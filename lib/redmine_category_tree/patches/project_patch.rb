module RedmineCategoryTree
  module Patches
    module ProjectPatch
      def self.prepended(base) # :nodoc:
        base.class_eval do
          unloadable
          has_many :issue_categories, lambda {order("#{IssueCategory.table_name}.lft")}, :dependent => :delete_all
        end
      end

      def copy_issue_categories(project)
        @parentCategoryMap = {}
        project.issue_categories.each do |issue_category|
          new_issue_category = IssueCategory.new
          new_issue_category.attributes = issue_category.attributes.dup.except("id", "project_id", "lft", "rgt", "parent_id")
          self.issue_categories << new_issue_category
          @parentCategoryMap[issue_category[:id]] = new_issue_category[:id]
        end
        project.issue_categories.each do |issue_category|
          if !issue_category[:parent_id].nil?
            new_issue_category = IssueCategory.find(@parentCategoryMap[issue_category[:id]])
            new_issue_category[:parent_id] = @parentCategoryMap[issue_category[:parent_id]]
            new_issue_category.save
          end
        end
        IssueCategory.rebuild!
      end
    end
  end
end
