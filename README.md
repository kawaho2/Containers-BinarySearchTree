# Containers-BinarySearchTree

A high-performance Binary Search Tree implementation providing efficient ordered data storage with logarithmic time complexity for core operations. Features comprehensive traversal methods, range queries, and full Collection protocol compliance.

![Pharo Version](https://img.shields.io/badge/Pharo-10+-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## What is a Binary Search Tree?

A Binary Search Tree (BST) is a hierarchical data structure where each node has at most two children, arranged so that for every node, all values in the left subtree are less than the node's value, and all values in the right subtree are greater. This property enables efficient searching, insertion, and deletion operations with O(log n) average time complexity.

## Loading 

The following script installs Containers-BinarySearchTree in Pharo.

```smalltalk
Metacello new
  baseline: 'ContainersBinarySearchTree';
  repository: 'github://pharo-containers/Containers-BinarySearchTree/src';
  load.
```

## If you want to depend on it 

Add the following code to your Metacello baseline or configuration:

```smalltalk
spec 
   baseline: 'ContainersBinarySearchTree' 
   with: [ spec repository: 'github://pharo-containers/Containers-BinarySearchTree/src' ].
```

## Why use Containers-BinarySearchTree?

Binary Search Trees solve the fundamental problem of **maintaining sorted data with efficient operations**. Perfect for applications requiring frequent searches, range queries, and ordered data processing.

### Key Benefits
- **Fast Search**: O(log n) lookup performance
- **Ordered Iteration**: Automatic sorted traversal
- **Range Queries**: Efficient retrieval of value ranges
- **Dynamic**: Efficient insertion and deletion
- **Collection Integration**: Full Pharo Collection protocol support

## Basic Usage

```smalltalk
"Create and populate a BST"
tree := CTBinarySearchTree new.
tree addAll: #(50 30 70 20 40 60 80).

"Search operations"
tree includes: 30. "=> true"
tree findMin. "=> 20"
tree findMax. "=> 80"

"Range queries"
middleValues := tree elementsFrom: 35 to: 65.
"=> OrderedCollection(40 50 60)"
```

## Real-World Use Cases

### Database Indexing Simulation
This example demonstrates how to use a BST to maintain an ordered index of database records for fast lookups.

```smalltalk
"Customer Database - Millions of records indexed by customer ID"
customerIndex := CTBinarySearchTree new.

"Add customer IDs as they're inserted into database"
customerIndex addAll: #(1001 1015 1008 1023 1003 1019 1011 1027).

"Fast customer lookup - O(log n) instead of scanning entire table"
customerExists := customerIndex includes: 1015.  "Returns: true"

recentCustomers := customerIndex elementsFrom: 1010 to: 1025.
"Returns: #(1011 1015 1019 1023) - Only customers in this ID range"

premiumCustomers := customerIndex elementsGreaterThan: 1020.
"Returns: #(1023 1027) - High-value customer IDs"

"Remove a customer ID when deleted"
customerIndex remove: 1008.
"Now customerIndex does not contain 1008"
```
### Why BST is Ideal for This Use Case
- **Fast Lookups**: Quickly check if a customer exists without scanning all records.
- **Ordered Data**: Automatically maintains sorted order of customer IDs.
- **Range Queries**: Efficiently retrieve customers within specific ID ranges.
- **Dynamic Updates**: Easily add or remove customer IDs as the database changes.


## Performance Comparison
Let's compare the performance of `OrderedCollection` and `CTBinarySearchTree` for searching a million elements.
This example benchmarks the time taken to search for an element in both data structures.

```smalltalk
| data orderedCollection bst startTime endTime ocTime bstTime |

data := (1 to: 1000000) shuffled.
orderedCollection := OrderedCollection new.
orderedCollection addAll: data.
bst := CTBinarySearchTree new.
bst addAll: data.

"Test 1: OrderedCollection Search"
startTime := Time microsecondClockValue.
1000 timesRepeat: [ orderedCollection includes: 50000 ].
endTime := Time microsecondClockValue.
ocTime := (endTime - startTime) / 1000.0.
Transcript show: 'OrderedCollection: ', ocTime asString, ' ms'; cr.

"Test 2: BST Search"
startTime := Time microsecondClockValue.
1000 timesRepeat: [ bst includes: 50000 ].
endTime := Time microsecondClockValue.
bstTime := (endTime - startTime) / 1000.0.
Transcript show: 'BST: ', bstTime asString, ' ms'; cr.
```

**Results:**
You can paste this benchmark code into Playgrounds to see the performance difference. `CTBinarySearchTree` will typically outperform `OrderedCollection` for large datasets, especially in search operations.


## Contributing

This is part of the Pharo Containers project. Feel free to contribute by implementing additional methods, improving tests, or enhancing documentation.
