require_relative 'game-node.rb'

class GameTree
  def initialize
    @root = GameNode.new(Board.new, :X)
  end

  def insert(val)
    new_tree_node = TreeNode.new(val)
    queue = [@root]

    until queue.empty?
      current_node = queue.shift
      unless current_node.full?
        current_node.append_child(new_tree_node)
        break
      else
        queue << current_node.left_child if current_node.left_child
        queue << current_node.right_child if current_node.right_child
      end
    end
  end

  def end_states(node=@root)
    result = []
    queue = [node]

    until queue.empty?
      current_node = queue.shift
      result << current_node

      queue << current_node.left_child if current_node.left_child
      queue << current_node.right_child if current_node.right_child
    end

    puts result
    result
  end

  # def end_states
  #   queue = [@root]
  #
  #   until queue.empty?
  #
  #   end
  #
  # end

end
