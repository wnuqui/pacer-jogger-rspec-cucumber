require 'spec_helper'

describe "jogger Traversal" do
  before(:all) do
    SocialNetwork.seed_data!

    @graph = Pacer.neo4j(Neo4j.db.graph)
    @jogger = Jogger.new(@graph.v(:name => 'John'))
  end

  it "should return John's friends" do
    @jogger.out(User.friends).should be_any
  end

  after(:all) do
    SocialNetwork.purge_data!
  end
end