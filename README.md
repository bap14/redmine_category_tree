# Redmine Category Tree

This module allows for the category lists within projects to act as trees instead of a single flat list.  This uses the awesome_nested_set contained within Redmine to maintain the tree structure.

## Installation

* Clone the repository
* Place in <redmine_root>/plugins
* Run `bundle exec rake redmine:plugins:migrate RAILS_ENV=production`
* Restart server (Passenger, WEBrick, Mongrel, etc.)

## Usage

Add a category as you normally would.  There will be a new dropdown labeled "Child category of" with a listing of all other categories available for that project.

**NOTE:** _If you are editing an existing category, since it cannot be a child of itself, that option will be disabled in the "Child category of" dropdown._

![Dropdown screenshot](https://github.com/brett-patterson-mss/redmine_category_tree/raw/master/docs/example-dropdown.png)

### Issues List

If the category module is selected for display, it will display the full category tree instead of just the selected category for those that are children.

![Issue list screenshot](https://github.com/brett-patterson-mss/redmine_category_tree/raw/master/docs/example-issue-listing.png)

### Tracking Category Changes

Changes to categories are tracked and will show up in the history as the full tree.

![Issue category change screenshot](https://github.com/brett-patterson-mss/redmine_category_tree/raw/master/docs/example-category-change-history.png)

### Managing Categories

The category listing will show in a tree format similar to the projects listing in the admin panel.

![Category list screenshot](https://github.com/brett-patterson-mss/redmine_category_tree/raw/master/docs/example-category-listing.png)
