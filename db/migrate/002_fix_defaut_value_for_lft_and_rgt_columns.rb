class FixDefautValueForLftAndRgtColumns < ActiveRecord::Migration[4.2]
  def self.up
    change_column :issue_categories, :lft, :integer, :null => false, :default => '0'
    change_column :issue_categories, :rgt, :integer, :null => false, :default => '0'

    if IssueCategory.count > 0
      IssueCategory.rebuild!
    end
  end
  
  def self.down
  end
end
