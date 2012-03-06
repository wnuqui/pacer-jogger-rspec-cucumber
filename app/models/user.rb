class User < Neo4j::Rails::Model
  property :name
  has_n(:friends).to(User).relationship(Friend)
  has_n(:likes).to(Movie).relationship(Like)
  index :name

  def recommended_friends
    # TODO: find how to get vertex using 'id'
    vertex = pacer_graph.v(:name => name)
    traversal = Jogger.new(vertex)
    SocialNetwork::Pacer::Utils.route_to_neo4j(traversal.recommended)
  end

  private
  def pacer_graph
    @graph = Pacer.neo4j(Neo4j.db.graph) unless defined?(@graph)
    @graph
  end
end