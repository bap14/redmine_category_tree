# ![](https://github.com/bpat1434/redmine_category_tree/raw/master/docs/icon-small.png) Redmine Category Tree

This module allows for the category lists within projects to act as trees instead of a single flat list.  This uses the awesome_nested_set contained within Redmine to maintain the tree structure.

## Added Features

* Categories can have child categories
* Categories are now sortable

## Installation

* Clone the repository
* Place in <redmine_root>/plugins
* Compile your assets (to get style changes)
* Follow normal Redmine plugin installation commands

## Usage

Add a category as you normally would.  There will be a new dropdown labeled "Child category of" with a listing of all other categories available for that project.

**NOTE:** _If you are editing an existing category, since it cannot be a child of itself, that option will be disabled in the "Child category of" dropdown._

![Dropdown screenshot](https://github.com/bpat1434/redmine_category_tree/raw/master/docs/example-dropdown.png)

### Issues List

If the category module is selected for display, it will display the full category tree instead of just the selected category for those that are children.

![Issue list screenshot](https://github.com/bpat1434/redmine_category_tree/raw/master/docs/example-issue-listing.png)

### Tracking Category Changes

Changes to categories are tracked and will show up in the history as the full tree.

![Issue category change screenshot](https://github.com/bpat1434/redmine_category_tree/raw/master/docs/example-category-change-history.png)

### Managing Categories

The category listing will show in a tree format similar to the projects listing in the admin panel.  You are presented with four separate options for ordering the categories.

1. Move to Top
2. Move Up
3. Move Down
4. Move to Bottom

**NOTE:** _If a category is unable to move in a particular fashion, that link will not be shown._

![Category list screenshot](https://github.com/bpat1434/redmine_category_tree/raw/master/docs/example-category-listing.png)

#### Move to Top

This will move the selected category to the top of the list for that project

#### Move Up

This will move the selected category up one slot so it will now show before the category (at the same level) above it.

#### Move Down

This will move the selected category down one slot so it will now show after the category (at the same level) below it.

#### Move to Bottom

This will move the selected category to the bottom of the list for that project

# Revision History

## 1.0.1
* Updated to work with Redmine 4.2.3.stable
* Fix compatibility with other plugins

## 1.0.0
* Add support for Rails >= 5

## 0.0.7

* Updated to work with Redmine 3.2.1
* Clarify a couple items in the readme

## 0.0.6

* Add awesome_nested_set gem dependency (for use with Redmine 3.x)

## 0.0.5

* Add support for context menus

## 0.0.4

* Add Russian translation of plugin (#7).  Thanks to AndreyBronin for the translation.
* Fix copying project with sub-categories causes error (#9)
* Fix IssueHelper patch not allowing for deletion of category with tickets assigned to it (#8)

## 0.0.3

* Adjusting default value(s) on nested set columns
* Fixing issue when adding new category of a "Comaprison of Fixnum with nil failed" error

## 0.0.2

* Merging KappaNossi's fix for 500 errors
* Fixing other 500 errors

## 0.0.1

Initial release of plugin
