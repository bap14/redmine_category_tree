class IssueCategoryActsAsNestedSet < ActiveRecord::Migration

  def self.up
    add_column :issue_categories, :parent_id, :integer, :null => true
	add_column :issue_categories, :lft, :integer, :null => true
	add_column :issue_categories, :rgt, :integer, :null => true

	IssueCategory.rebuild!
  end

  def self.down
  	remove_column :issue_categories, :parent_id
	remove_column :issue_categories, :lft
	remove_column :issue_categories, :rgt
  end

end
