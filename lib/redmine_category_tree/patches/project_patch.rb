module RedmineCategoryTree
  module Patches
    module ProjectPatch
      def self.included(base) # :nodoc:
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          has_many :issue_categories, :dependent => :delete_all, :order => "#{IssueCategory.table_name}.lft"
        end
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end
