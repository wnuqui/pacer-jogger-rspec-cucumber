module SocialNetwork
  def self.seed_data!
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

  def self.purge_data!
    User.all.each { |user| user.destroy }
    Friend.all.each { |friend| friend.destroy }
    Movie.all.each { |movie| movie.destroy }
    Like.all.each { |like| like.destroy }
  end
end