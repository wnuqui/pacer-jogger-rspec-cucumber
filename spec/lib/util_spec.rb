require 'spec_helper'

describe SocialNetwork::Pacer::Utils do
  before(:all) do
    @john   = User.create(:name => 'John')
    @graph  = Pacer.neo4j(Neo4j.db.graph)
    @route  = @graph.v(:name => 'John')
  end

  context ".route_to_hash" do
    before(:all) do
      @result = SocialNetwork::Pacer::Utils.route_to_hashes(@route)
    end

    it "should return Array" do
      @result.should be_a(Array)
    end

    it "should return Array of Hash(es)" do
      @result.first.should be_a(Hash)
    end

    it "should return value for a key" do
      @result.first["name"].should == @john["name"]
    end
  end

  context ".route_to_json" do
    before(:all) do
      @result = JSON.parse(SocialNetwork::Pacer::Utils.route_to_jsons(@route))
    end

    it "should return Array" do
      @result.should be_a(Array)
    end

    it "should return Array of JSON(s)" do
      @result.first.should be_a(Hash)
    end

    it "should return value for a key" do
      @result.first["name"].should == @john["name"]
    end
  end

  context ".route_to_nodes" do
    before(:all) do
      @result = SocialNetwork::Pacer::Utils.route_to_neo4j(@route)
    end

    it "should return Array" do
      @result.should be_a(Array)
    end

    it "should return Array of Neo4j node" do
      @result.first.should equal(@john)
    end

    it "should return value for a key" do
      @result.first["name"].should == @john["name"]
    end
  end

  after(:all) do
    User.all.each { |user| user.destroy }
  end
end