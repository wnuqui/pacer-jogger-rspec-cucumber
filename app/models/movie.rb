class Movie < Neo4j::Rails::Model
  property :title
  property :genre
  has_n(:likers).from(User, :likes)
  index :title, :genre
end