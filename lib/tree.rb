# frozen_string_literal: true

require_relative 'node'

# binary search tree
class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.length - 1) / 2
    left = build_tree(array[0...mid])
    right = build_tree(array[mid + 1..-1])
    Node.new(array[mid], left, right)
  end

  def insert(data, node = @root)
    return if data == node.data

    if data < node.data
      node.left.nil? ? node.left = Node.new(data) : insert(data, node.left)
    else
      node.right.nil? ? node.right = Node.new(data) : insert(data, node.right)
    end
  end

  def delete(data, node = @root)
    return nil if node.nil?

    if data == node.data
      return node.left if (!node.left.nil? && node.right.nil?) || (node.left.nil? && node.right.nil?)
      return node.right if node.left.nil? && !node.right.nil?

      furthest_left = node.right
      furthest_left = furthest_left.left until furthest_left.left.nil?
      node.right = delete(furthest_left.data, node.right)
      node.data = furthest_left.data
    else
      data > node.data ? node.right = delete(data, node.right) : node.left = delete(data, node.left)
    end
    node
  end

  def find(data, node = @root)
    return node if data == node.data || node.nil?

    data < node.data ? find(data, node.left) : find(data, node.right)
  end

  def level_order(&block)
    values = []
    queue = []
    queue.push(@root)
    until queue.empty?
      current = queue.shift
      values << current.data
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end
    block_given? ? values.each(&block) : values
  end

  def preorder(values = [], node = @root, &block)
    return if node.nil?

    values << node.data
    preorder(values, node.left, &block)
    preorder(values, node.right, &block)
    node.equal?(@root) && block_given? ? values.each(&block) : values
  end

  def inorder(values = [], node = @root, &block)
    return if node.nil?

    inorder(values, node.left, &block)
    values << node.data
    inorder(values, node.right, &block)
    node.equal?(@root) && block_given? ? values.each(&block) : values
  end

  def postorder(values = [], node = @root, &block)
    return if node.nil?

    postorder(values, node.left, &block)
    postorder(values, node.right, &block)
    values << node.data
    node.equal?(@root) && block_given? ? values.each(&block) : values
  end

  def height(node, height = 0)
    return height - 1 if node.nil?

    node = find(node) unless node.instance_of?(Node)
    heights = []
    heights << height(node.left, height + 1)
    heights << height(node.right, height + 1)
    heights.flatten.max
  end

  def depth(data, node = @root, depth = 0)
    return depth if data == node.data
    return nil if (node.left.nil? && data < node.data) || (node.right.nil? && data > node.data)

    data < node.data ? depth(data, node.left, depth + 1) : depth(data, node.right, depth + 1)
  end

  def balanced?(node = @root)
    return true if node.nil?

    (height(node.left) - height(node.right)).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @array = inorder
    @root = build_tree(@array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
