require 'spec_helper'

describe "neo4j Traversal" do
  before(:all) do
    @john   = User.create(:name => 'John')
    @allen  = User.create(:name => 'Allen')
    @denise = User.create(:name => 'Denise')
    @jay    = User.create(:name => 'Jay')

    User.transaction do
      Neo4j::Relationship.create(User.friends, @john, @allen, :since => 2000)
      Neo4j::Relationship.create(User.friends, @john, @denise, :since => 1999)
      Neo4j::Relationship.create(User.friends, @allen, @jay, :since => 2005)
    end
  end

  it "should traverse friends at depth(1)" do
    friends = @john.outgoing(User.friends).depth(1)
    friends.should include(@allen)
    friends.should include(@denise)
    friends.should_not include(@jay)
  end

  it "should traverse friends at depth(:all)" do
    friends = @john.outgoing(User.friends).depth(2)
    friends.should include(@allen)
    friends.should include(@denise)
    friends.should include(@jay)
  end

  after(:all) do
    SocialNetwork.purge_data!
  end
end