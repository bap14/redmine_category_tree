get 'issue_categories/:id/move/:direction', :to => 'issue_categories#move_category'

Rails.application.routes.draw do
  resources :issue_categories do
    member do
      post 'archive'
      post 'unarchive'
    end
  end
end
