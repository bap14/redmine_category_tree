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
					
					#THE BEFORE_FILTER IS WHO GIVES THE AUTHORIZATION TO EXECUTE THE FUNCTION
					before_filter :authorize, :except => [:archive, :unarchive, :archived?, :unarchived?]
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
		

				def archive
				  @category.archived = true
				  if @category.save
					respond_to do |format|
					  format.html do
						flash[:notice] = l(:plugin_notice_successful_archived)
						redirect_to_settings_in_projects
					  end
					  format.js
					  format.api { render :action => 'show', :status => :created, :location => issue_category_path(@category) }
					end
				  else
					respond_to do |format|
					  format.html { render :action => 'new'}
					  format.js   { render :action => 'new'}
					  format.api { render_validation_errors(@category) }
					end
				  end
				end
				
				def unarchive
				  @category.archived = false
				  if @category.save
					respond_to do |format|
					  format.html do
						flash[:notice] = l(:plugin_notice_successful_archived)
						redirect_to_settings_in_projects
					  end
					  format.js
					  format.api { render :action => 'show', :status => :created, :location => issue_category_path(@category) }
					end
				  else
					respond_to do |format|
					  format.html { render :action => 'new'}
					  format.js   { render :action => 'new'}
					  format.api { render_validation_errors(@category) }
					end
				  end
				end
				
				def archived?
				   @category.archived
				end

				def unarchived?
				  !@category.archived
				end
		
			end
			
		end
	end
end
