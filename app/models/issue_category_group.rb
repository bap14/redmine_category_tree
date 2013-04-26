class IssueCategoryGroup < ActiveRecord::Base
	include Redmine::SafeAttributes
	has_many :issue_categories

  def to_s; name end
end
