Feature: Add Categories
  As a blog administrator
  In order to share my thoughts with the world
  I want to be able to add categories to my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully add categories
    Given I am on the new category page
    When I fill in "name" with "fun"
    And I fill in "keywords" with "friend happy song"
    And I fill in "permalink" with "something"
    And I fill in "description" with "cool beans"
    And I press "Save"
    Then I should be on the new category page
