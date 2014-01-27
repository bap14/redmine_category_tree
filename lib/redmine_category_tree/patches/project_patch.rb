module RedmineCategoryTree
  module Patches
    module ProjectPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          has_many :issue_categories, :dependent => :delete_all, :order => "#{IssueCategory.table_name}.lft"
          
          alias_method_chain :copy_issue_categories, :subcategories
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def copy_issue_categories_with_subcategories(project)
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
end
