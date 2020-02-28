Redmine::Plugin.register :redmine_category_tree do
	name 'Redmine Category Tree'
	author 'Brett Patterson'
	description 'Adds ability for categories to have "children"'
	version '1.0.0'
	
	permission :move_category, :issue_categories => :move_category

	requires_redmine :version_or_higher => '4.0.0'
end

require 'redmine_category_tree/hooks/redmine_category_tree_hooks'
require File.dirname(__FILE__) + '/app/views/helpers/redmine_category_tree/issue_category_helper.rb'

#Rails.configuration.to_prepare do
((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare do 

  ## Helpers first
	require_dependency 'application_helper'
	unless ApplicationHelper.included_modules.include?(RedmineCategoryTree::Patches::ApplicationHelperPatch)
    ApplicationHelper.send(:prepend, RedmineCategoryTree::Patches::ApplicationHelperPatch)
  end

	require_dependency 'queries_helper'
	unless QueriesHelper.included_modules.include?(RedmineCategoryTree::Patches::QueriesHelperPatch)
		QueriesHelper.send(:prepend, RedmineCategoryTree::Patches::QueriesHelperPatch)
  end

	require_dependency 'issues_helper'
	unless IssuesHelper.included_modules.include?(RedmineCategoryTree::Patches::IssuesHelperPatch)
		IssuesHelper.send(:prepend, RedmineCategoryTree::Patches::IssuesHelperPatch)
	end

  ## Models
	require_dependency 'issue_category'
	unless IssueCategory.included_modules.include?(RedmineCategoryTree::Patches::IssueCategoryPatch)
		IssueCategory.send(:prepend, RedmineCategoryTree::Patches::IssueCategoryPatch)
  end

	require_dependency 'issue_query'
	unless IssueQuery.ancestors.include?(RedmineCategoryTree::Patches::IssueQueryPatch)
		IssueQuery.send(:prepend, RedmineCategoryTree::Patches::IssueQueryPatch)
	end

	require_dependency 'project'
	unless Project.included_modules.include?(RedmineCategoryTree::Patches::ProjectPatch)
		Project.send(:prepend, RedmineCategoryTree::Patches::ProjectPatch)
  end

  ## Controllers
	require_dependency 'issues_controller'
	unless IssuesController.included_modules.include?(RedmineCategoryTree::Patches::IssuesControllerPatch)
		IssuesController.send(:prepend, RedmineCategoryTree::Patches::IssuesControllerPatch)
	end

	require_dependency 'issue_categories_controller'
	unless IssueCategoriesController.included_modules.include?(RedmineCategoryTree::Patches::IssueCategoriesControllerPatch)
		IssueCategoriesController.send(:prepend, RedmineCategoryTree::Patches::IssueCategoriesControllerPatch)
	end

	require_dependency 'reports_controller'
	unless ReportsController.included_modules.include?(RedmineCategoryTree::Patches::ReportsControllerPatch)
		ReportsController.send(:prepend, RedmineCategoryTree::Patches::ReportsControllerPatch)
	end

	require_dependency 'context_menus_controller'
	unless ContextMenusController.included_modules.include?(RedmineCategoryTree::Patches::ContextMenusControllerPatch)
		ContextMenusController.send(:prepend, RedmineCategoryTree::Patches::ContextMenusControllerPatch)
	end
end
