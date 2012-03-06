require 'spec_helper'

describe User do
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
  end

  context "on instance methods" do
    context "#recommended_friends" do
      subject { @john.recommended_friends }

      it { should be_a(Array) }
      specify { subject.first.should equal(@jay) }
    end
  end

  after(:all) do
    SocialNetwork.purge_data!
  end
end