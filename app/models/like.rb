class Like < Neo4j::Rails::Relationship
  property :since
  index :since
end