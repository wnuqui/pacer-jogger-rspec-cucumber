require 'spec_helper'

describe "recommended friend Traversal" do
  before(:all) do
    @john   = User.create(:name => 'John')
    @allen  = User.create(:name => 'Allen')
    @denise = User.create(:name => 'Denise')
    @jay    = User.create(:name => 'Jay')

    User.transaction do
      Neo4j::Relationship.create(User.friends, @john, @allen, :since => 2000)
      Neo4j::Relationship.create(User.friends, @john, @denise, :since => 1999)
      Neo4j::Relationship.create(User.friends, @jay, @allen, :since => 2005)
    end

    @graph = Pacer.neo4j(Neo4j.db.graph)
  end

  context "Recommended Friends neo4j Traversals" do
    it "should return recommended friends by outgoing-incoming" do
      # get @jay as recommended for @john thru @allen
      recommended = @john.outgoing(User.friends).adapt_to_traverser.incoming(User.friends).depth(:all)
      recommended.should include(@jay)
    end

    it "should return recommended friends by incoming-outgoing" do
      # get @john and @denise as recommended for @jay thru @allen
      recommended = @jay.incoming(User.friends).adapt_to_traverser.outgoing(User.friends).depth(:all)
      recommended.should include(@john)
      recommended.should include(@denise)
    end
  end

  context "Recommended Friends pacer Traversals" do
    it "should return recommended friends by in-out and removing exceptions" do
      john = @graph.v(:name => 'John')
      friends = john.out(User.friends)
      recommended = friends.in(User.friends).except(john).except(friends)
      recommended.should be_any
    end
  end

  after(:all) do
    SocialNetwork.purge_data!
  end
end