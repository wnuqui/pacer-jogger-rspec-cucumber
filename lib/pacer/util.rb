module SocialNetwork
  module Pacer
    module Utils
      class << self
        # Returns array of Hash representations given:
        #
        # * :route - This is the Pacer::Route returned by a Pacer traversal
        #
        def route_to_hashes(route)
          nodes = []
          route.each do |node|
            properties = node.properties
            properties.delete("_classname")
            nodes << properties.merge("id" => node.id)
          end
          nodes
        end

        # Returns array of JSON representations given:
        #
        # * :route - This is the Pacer::Route returned by a Pacer traversal
        #
        def route_to_jsons(route)
          route_to_hashes(route).to_json
        end

        # Returns array of Neo4j nodes or edges(relationships) given:
        #
        # * :route - This is the Pacer::Route returned by a Pacer traversal
        #
        def route_to_neo4j(route)
          nodes = []
          route.each do |node|
            klass = node.properties.delete("_classname")
            nodes << klass.constantize.find(node.id)
          end
          nodes
        end
      end
    end
  end
end