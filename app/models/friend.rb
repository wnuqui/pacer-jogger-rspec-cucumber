class Friend < Neo4j::Rails::Relationship
  property :since
  property :private
  
  index :since, :private
end