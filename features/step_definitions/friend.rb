Given /^I register to social network as "([^"]*)"$/ do |name|
  @I = User.create :name => name
end

Given /^"([^"]*)" registered to social network$/ do |name|
  @friends = [] if !defined?(@friends)
  @friends << User.create(:name => name)
end

When /^I added them as friends$/ do
  @friends.each do |friend|
    @I.friends << friend
    rel = @I.friends_rels.first
    rel['since'] = 2000
    rel.save
  end
end

Then /^I see them in my list of friends$/ do
  @friends.each do |friend|
    @I.friends.include? friend
  end
end