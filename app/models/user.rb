class User < Neo4j::Rails::Model
  property :name
  has_n(:friends).to(User).relationship(Friend)
  has_n(:likes).to(Movie).relationship(Like)
  index :name

  def recommended_friends
    SocialNetwork::Pacer::Utils.route_to_neo4j(pacer_traversal.recommended)
  end

  private
  def pacer_graph
    @graph = Pacer.neo4j(Neo4j.db.graph) unless defined?(@graph)
    @graph
  end

  def pacer_traversal
    Jogger.new(
      pacer_graph.vertex(id)
    )
  end
end