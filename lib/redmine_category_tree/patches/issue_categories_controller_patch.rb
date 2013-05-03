require File.dirname(__FILE__) + '/../../../app/views/helpers/redmine_category_tree/issue_category_helper.rb'

module RedmineCategoryTree
	module Patches
		module IssueCategoriesControllerPatch
			def self.included(base) # :nodoc:
				base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
					unloadable

					helper RedmineCategoryTree::IssueCategoryHelper
				end
			end

			module ClassMethods
			end

			module InstanceMethods
			  def move_category
			    categoryId = params[:id]
			    direction = params[:direction]
			    
          category = IssueCategory.find(categoryId)
          
          if !category.id
            flash[:notice] = l(:issue_category_not_found)
            redirect_to :controller => 'projects', :action => 'settings', :tab => 'categories', :id => @project
          end
          
          case direction
          when "top"
            raise "Only root level categories can move to the top" if !category.root?
            raise "Selected category has no siblings above it" if !category.left_sibling
            
            category.move_to_left_of category.siblings.first
          when "up"
            raise "Selected category has no siblings above it" if !category.left_sibling
            
            category.move_left
          when "down"
            raise "Selected category has no siblings below it" if !category.right_sibling
            
            category.move_right
          when "bottom"
            raise "Only root level categories can move to the bottom" if !category.root?
            raise "Selected category has no siblings below it" if !category.right_sibling
            
            category.move_to_right_of category.siblings.last
          else
            raise "Unknown direction or direction not provided"
          end
          
          flash[:notice] = l(:issue_category_successful_move)
          redirect_to :controller => 'projects', :action => 'settings', :tab => 'categories', :id => @project
        end
			end
		end
	end
end
