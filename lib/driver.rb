# frozen_string_literal: true

require_relative 'tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "\nbalanced?\n\n"
p tree.balanced?
puts "\nlevel order\n\n"
tree.level_order { |i| p i }
puts "\npreorder\n\n"
tree.preorder { |i| p i }
puts "\ninorder\n\n"
tree.inorder { |i| p i }
puts "\npostorder\n\n"
tree.postorder { |i| p i }
puts "\nadding values\n\n"
(Array.new(10) { rand(101..150) }).each { |i| tree.insert(i) } 
tree.pretty_print
puts "\nbalanced?\n\n"
p tree.balanced?
puts "\nrebalance\n\n"
tree.rebalance
tree.pretty_print
puts "\nbalanced?\n\n"
p tree.balanced?
puts "\nlevel order\n\n"
tree.level_order { |i| p i }
puts "\npreorder\n\n"
tree.preorder { |i| p i }
puts "\ninorder\n\n"
tree.inorder { |i| p i }
puts "\npostorder\n\n"
tree.postorder { |i| p i }