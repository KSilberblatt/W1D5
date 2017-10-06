require_relative '00_tree_node'

class KnightPathFinder
  def initialize(pos)
    @pos = pos
    @visited_position = [pos]
    @node = PolyTreeNode.new(pos)
  end

  def build_move_tree
    queue = [@node]

    until queue.empty?
      next_node = queue.shift
      new_move_positions(next_node.value).each do |next_pos|
        next_node.add_child(next_pos)
      end
      queue.concat(next_node.children) unless next_node.children.empty?
    end
  end

  def new_move_positions(pos)
    new_moves = valid_moves(pos).reject do |valid_moves_pos|
      @visited_position.include?(valid_moves_pos)
    end
    @visited_position.concat(new_moves)
    new_moves
  end

  def valid_moves(pos)
    valid_moves = []
    valid_moves << [pos[0] + 2, pos[1] + 1] if valid_move?([pos[0] + 2, pos[1] + 1])
    valid_moves << [pos[0] + 2, pos[1] - 1] if valid_move?([pos[0] + 2, pos[1] - 1])
    valid_moves << [pos[0] - 2, pos[1] + 1] if valid_move?([pos[0] - 2, pos[1] + 1])
    valid_moves << [pos[0] - 2, pos[1] - 1] if valid_move?([pos[0] - 2, pos[1] - 1])
    valid_moves << [pos[0] + 1, pos[1] + 2] if valid_move?([pos[0] + 1, pos[1] + 2])
    valid_moves << [pos[0] + 1, pos[1] - 2] if valid_move?([pos[0] + 1, pos[1] - 2])
    valid_moves << [pos[0] - 1, pos[1] + 2] if valid_move?([pos[0] - 1, pos[1] + 2])
    valid_moves << [pos[0] - 1, pos[1] - 2] if valid_move?([pos[0] - 1, pos[1] - 2])
    valid_moves
  end

  def valid_move?(pos)
    return false unless pos[0].between?(0, 8) && pos[1].between?(0, 8)
    true
  end

end
