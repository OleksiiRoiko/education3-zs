from itertools import product

def comparator(input_list, i, j):
    # Swap the two values if they are out of order
    if input_list[i] > input_list[j]:
        input_list[i], input_list[j] = input_list[j], input_list[i]
    return input_list

def generate_all_permutations():
    return list(product([0, 1], repeat=5))

def sort_network(input_list):
    # Apply the comparator function according to the network's design
    input_list = comparator(input_list, 0, 1)
    input_list = comparator(input_list, 1, 2)
    input_list = comparator(input_list, 0, 1)
    input_list = comparator(input_list, 2, 3)
    input_list = comparator(input_list, 1, 2)
    input_list = comparator(input_list, 3, 4)
    input_list = comparator(input_list, 0, 1)
    input_list = comparator(input_list, 2, 3)
    input_list = comparator(input_list, 1, 2)
    input_list = comparator(input_list, 0, 1)

    return input_list

# Test the sorting network with all permutations of 5 values
permutations = generate_all_permutations()
print(permutations)
sorted_permutations = [sort_network(list(p)) for p in permutations]

# Check if all permutations are sorted correctly
all_sorted_correctly = all(p == sorted(p) for p in sorted_permutations)

# Output the result
print(all_sorted_correctly, sorted_permutations[:10])  # Show the first 5 sorted permutations as a sample
