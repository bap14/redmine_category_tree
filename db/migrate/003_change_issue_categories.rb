class ChangeIssueCategories < ActiveRecord::Migration
  class IssueCategory < ActiveRecord::Base
  end
  
  def up
    add_column :issue_categories, :archived, :boolean, :default => false
  end

  def down
    remove_column :issue_categories, :archived
  end
end