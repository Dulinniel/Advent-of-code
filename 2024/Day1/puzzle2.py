# Create a Node class
class Node:
  def __init__(self, data):
    self.data = data
    self.next = None

# Create a LinkedList class
class LinkedList:
  def __init__(self):
    self.head = None

  # Method to add a node at the beginning of the List
  def push_front(self, data):
    new_node = Node(data)
    if ( self.head is None ):
      self.head = new_node
    else:
      new_node.next = self.head
      self.head = new_node

  def insert(self, data):
    if ( self.head is None ) or ( data < self.head.data ):
      self.push_front(data)
      return
    
    current_node = self.head
    while ( current_node.next ) and ( current_node.next.data < data ):
      current_node = current_node.next

    new_node = Node(data)
    new_node.next = current_node.next
    current_node.next = new_node

  # Print the size of the linked list
  def length(self):
    size = 0
    current_node = self.head
    while ( current_node ):
      size += 1
      current_node = current_node.next
    return size

  # Print the linked list
  def print(self):
    current_node = self.head
    while ( current_node ):
      print(current_node.data)
      current_node = current_node.next


def count_duplicate(sorted_left_input, sorted_right_input):
  duplicates = {}

  while ( sorted_left_input ) and ( sorted_right_input ):
    left_tuple = None
    right_tuple = None

    if ( sorted_left_input.data not in duplicates ): left_tuple = (1, 0)
    else: left_tuple = ( duplicates[sorted_left_input.data][0] + 1, duplicates[sorted_left_input.data][1] )

    duplicates[sorted_left_input.data] = left_tuple
    
    if ( sorted_right_input.data not in duplicates ): right_tuple = (0, 1)
    else: right_tuple = ( duplicates[sorted_right_input.data][0], duplicates[sorted_right_input.data][1] + 1 )

    duplicates[sorted_right_input.data] = right_tuple

    sorted_left_input = sorted_left_input.next
    sorted_right_input = sorted_right_input.next
  return duplicates

def get_similarities(sorted_left_input, sorted_right_input):
  similarities = 0
  current_sorted_left_input = sorted_left_input.head
  current_sorted_right_input = sorted_right_input.head
  duplicates = count_duplicate(current_sorted_left_input, current_sorted_right_input)
  # { 4 : ( 3, 5 ) }
  # ( 4 * 5 ) + ( 4 * 5 ) + ( 4 * 5 ) == ( 4 * 5 ) * 3
  for ids in duplicates:
    similarities += ( ids * duplicates[ids][1] ) * duplicates[ids][0]
  return similarities

Left_input = LinkedList()
Right_input = LinkedList()

with open("input.txt", 'r') as file:
  for line in file.readlines():
    ids = line.split(' ')
    left_ID = ids[0].strip()
    right_ID = ids[-1].strip()
    if ( left_ID != '' ) and ( right_ID != '' ):
      Left_input.insert(int(left_ID))
      Right_input.insert(int(right_ID))
  file.close()

print("Left input: ")
Left_input.print()
print("Right input: ")
Right_input.print()

similarities = get_similarities(Left_input, Right_input)
print("Distance: ", similarities)