require 'spec_helper'

describe "pacer Traversal" do
  before(:all) do
    SocialNetwork.seed_data!

    @graph = Pacer.neo4j(Neo4j.db.graph)
  end

  it "should return 'John'" do
    @graph.v(:name => 'John').should be_any
  end

  it "should return John's friends" do
    @graph.v(:name => 'John').out(User.friends).should be_any
  end

  after(:all) do
    SocialNetwork.purge_data!
  end
end