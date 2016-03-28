Feature: Add and Edit Categories
  As a blog administrator
  In order to share my thoughts with the world
  I want to be able to add categories to my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Successfully add categories
    Given I am on the new category page
    Then I should not see "fun"
    When I fill in "category_name" with "fun"
    And I fill in "category_keywords" with "friend, happy, song"
    And I fill in "category_permalink" with "something"
    And I fill in "category_description" with "cool beans"
    And I press "Save"
    Then I should be on the new category page
    And I should see "fun"
    And I should see "friend, happy, song"
    And I should see "something"
    And I should see "cool beans"
    And I should have 2 categories

  Scenario: Successfully edit categories
    Given I am on the edit category page
    Then I should see "general"
    When I fill in "category_name" with "fun"
    And I fill in "category_keywords" with "friend, happy, song"
    And I fill in "category_permalink" with "something"
    And I fill in "category_description" with "cool beans"
    And I press "Save"
    Then I should be on the new category page
    Then I should not see "general"
    And I should see "fun"
    And I should see "friend, happy, song"
    And I should see "something"
    And I should see "cool beans"
    And I should have 1 categories
