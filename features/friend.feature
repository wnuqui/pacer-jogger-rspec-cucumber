Feature: Making Friends
  In order to make friends
  As a user
  I want to add friend

Scenario: Add Friend
  Given I register to social network as "John"
  And "Allen" registered to social network
  And "Denise" registered to social network
  When I added them as friends
  Then I see them in my list of friends