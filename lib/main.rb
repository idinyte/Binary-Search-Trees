# frozen_string_literal: true

require_relative 'tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
puts "\n insert 12, 9, 68 \n\n"
tree.insert(12)
tree.insert(9)
tree.insert(68)
tree.insert(21)
tree.pretty_print
puts "\n delete 12, 9, 21, 67, 4, 8 \n\n"
tree.delete(12)
tree.delete(9)
tree.delete(21)
tree.delete(67)
tree.delete(4)
tree.delete(8)
tree.pretty_print
print "\n find 324 \n\n"
p tree.find(324)

puts "\nlevel order\n\n"
tree.level_order { |data| p data }
puts "\n#{tree.level_order}"

puts "\npreorder\n\n"
tree.preorder { |data| p data }
puts "\n#{tree.preorder}"

puts "\ninorder\n\n"
tree.inorder { |data| p data }
puts "\n#{tree.inorder}"

puts "\npostorder\n\n"
tree.postorder { |data| p data }
puts "\n#{tree.postorder}"

puts "\nheight 23 = #{tree.height(5)}"

puts "\ndepth 7 = #{tree.depth(7)}"

puts "\nbalanced? = #{tree.balanced?}\n\n"

tree.rebalance
tree.pretty_print

puts "\nbalanced? = #{tree.balanced?}\n\n"