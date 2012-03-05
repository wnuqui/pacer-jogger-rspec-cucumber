class User < Neo4j::Rails::Model
  property :name
  has_n(:friends).to(User).relationship(Friend)
  has_n(:likes).to(Movie).relationship(Like)
  index :name
end