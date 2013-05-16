require 'redmine'

Redmine::Plugin.register :redmine_category_tree do
	name 'Redmine Category Tree'
	author 'Brett Patterson'
	description 'Adds ability for categories to have "children"'
	version '0.0.2'
	
	permission :move_category, :issue_categories => :move_category

	requires_redmine :version_or_higher => '2.0.3'
end

require 'redmine_category_tree/hooks/redmine_category_tree_hooks'

ActionDispatch::Callbacks.to_prepare do
	require_dependency 'issue_category'
	unless IssueCategory.included_modules.include?(RedmineCategoryTree::Patches::IssueCategoryPatch)
		IssueCategory.send(:include, RedmineCategoryTree::Patches::IssueCategoryPatch)
	end

	require_dependency 'issues_controller'
	unless IssuesController.included_modules.include?(RedmineCategoryTree::Patches::IssuesControllerPatch)
		IssuesController.send(:include, RedmineCategoryTree::Patches::IssuesControllerPatch)
	end

	require_dependency 'issue_categories_controller'
	unless IssueCategoriesController.included_modules.include?(RedmineCategoryTree::Patches::IssueCategoriesControllerPatch)
		IssueCategoriesController.send(:include, RedmineCategoryTree::Patches::IssueCategoriesControllerPatch)
	end

	require_dependency 'project'
	unless Project.included_modules.include?(RedmineCategoryTree::Patches::ProjectPatch)
		Project.send(:include, RedmineCategoryTree::Patches::ProjectPatch)
  end

  require_dependency 'projects_controller'
  unless ProjectsController.included_modules.include?(RedmineCategoryTree::Patches::ProjectsControllerPatch)
    ProjectsController.send(:include, RedmineCategoryTree::Patches::ProjectsControllerPatch)
  end
	
	require_dependency 'reports_controller'
  unless ReportsController.included_modules.include?(RedmineCategoryTree::Patches::ReportsControllerPatch)
    ReportsController.send(:include, RedmineCategoryTree::Patches::ReportsControllerPatch)
  end

	require_dependency 'queries_helper'
	unless QueriesHelper.included_modules.include?(RedmineCategoryTree::Patches::QueriesHelperPatch)
		QueriesHelper.send(:include, RedmineCategoryTree::Patches::QueriesHelperPatch)
	end

	require_dependency 'issues_helper'
	unless IssuesHelper.included_modules.include?(RedmineCategoryTree::Patches::IssuesHelperPatch)
		IssuesHelper.send(:include, RedmineCategoryTree::Patches::IssuesHelperPatch)
	end
end
