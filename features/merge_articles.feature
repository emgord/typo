Feature: Merge Articles
  As a blog administrator
  In order to share my thoughts with the world
  I want to be able to merge similar articles on my blog

  Background:
    Given the blog is set up

  Scenario: Non-admin cannot merge articles
    Given I am logged in as a contributor

  Scenario: Admin can successfully merge articles
    Given I am logged into the admin panel
    And I have two similar articles titled Cats, Dogs
    And I am on the manage articles page
    Then I should see "Cats"
    And I should see "Dogs"
    When I follow "Edit"
    Then I should be on the edit articles page
    And I should see "Merge Articles"
    When I fill in "merge_with" with "3"
    And I press "Merge"
    Then I should be on the manage articles page
    And I should see "Cats"
    And I should not see "Dogs"
    When I follow "Show"
    Then I should see "I love cats I love dogs"
