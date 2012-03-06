class Jogger
  module NamedTraversals
    class << self
      def recommended(traversal)
        friends = traversal.out(User.friends)
        friends.in(User.friends).except(traversal).except(friends)
      end
    end
  end
end