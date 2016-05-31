require_relative "00_tree_node"

class KnightPathFinder
  attr_reader :visited_positions, :root

  def initialize(pos=[0,0])
    @starting_pos = pos
    @visited_positions = [@starting_pos]
    build_move_tree
  end

  def build_move_tree
    head_node = PolyTreeNode.new(@starting_pos)
    queue = [head_node]
    @root = head_node

    until queue.empty?

      head = queue.shift
      children_pos = new_move_positions(head.value)

      children_pos.each do |child_pos|
        child = PolyTreeNode.new(child_pos)
        head.add_child(child)
        queue << child
      end

    end
  end

  def self.valid_moves(pos)
    y, x = pos
    [[y-1, x-2],
    [y-2, x-1],
    [y-2, x+1],
    [y-1, x+2],
    [y+1, x+2],
    [y+2, x+1],
    [y+2, x-1],
    [y-1, x-2]].select { |pos| in_range?(pos) }
  end

  def self.in_range?(pos)
    pos.all? { |idx| idx.between?(0, 7)  }
  end

  def new_move_positions(pos)
    all_positions = KnightPathFinder.valid_moves(pos)
    valid_positions = all_positions.reject do |pos|
      visited_positions.include?(pos)
    end
    visited_positions.concat(valid_positions)
    valid_positions
  end

  def find_path(end_pos)
    end_node = root.dfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    current_node = end_node
    path = [end_node.value]
    until current_node.parent.nil?
      path << current_node.parent.value
      current_node = current_node.parent
    end
    path
  end
end
