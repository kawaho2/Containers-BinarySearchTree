"
I test the Binary Search Tree implementation (CTBinarySearchTree).

I verify correctness of all tree operations including insertion, deletion, search, traversals, and collection protocol methods. I test edge cases like empty trees, single nodes, and complex removal scenarios.

I ensure the BST maintains its ordering property and handles duplicates correctly.
"
Class {
	#name : 'CTBinarySearchTreeTest',
	#superclass : 'TestCase',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BinarySearchTree-Tests',
	#package : 'Containers-BinarySearchTree-Tests'
}

{ #category : 'running' }
CTBinarySearchTreeTest >> setUp [
	super setUp.
	tree := CTBinarySearchTree new
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testAddMultipleElements [

	tree addAll: #(50 30 70).
	
	self assert: tree size equals: 3
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testAddSingleElement [

	tree add: 42.
	self deny: tree isEmpty.
	self assert: tree size equals: 1
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testAsArray [
	
	
	| result |
		tree addAll: #(50 30 70 20 40).

	result := tree asArray.
	self assert: result equals: #(20 30 40 50 70)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testAtIfAbsent [

	tree addAll: #(50 30 70).
	self assert: (tree at: 30 ifAbsent: [ #notFound ]) equals: 30.
	self assert: (tree at: 99 ifAbsent: [ #notFound ]) equals: #notFound
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testBSTValidation [

	| emptyTree |
	emptyTree := CTBinarySearchTree new.
	self assert: emptyTree validateBSTProperty.
	
	tree addAll: #(50 30 70 20 40).
	self assert: tree validateBSTProperty.
	
	"Test after removal"
	tree remove: 30.
	self assert: tree validateBSTProperty
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testClear [

	tree addAll: #(1 2 3 4 5).
	tree clear.
	
	self assert: tree isEmpty.
	self assert: tree size equals: 0
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testCollectionMethods [

		| doubled evens found |
	tree addAll: #(50 30 70 20 40).

	
	doubled := tree collect: [ :each | each * 2 ].
	self assert: doubled asArray equals: #(40 60 80 100 140).
	
	evens := tree select: [ :each | each even ].
	self assert: evens asArray equals: #(20 30 40 50 70).
	
	found := tree detect: [ :each | each > 45 ] ifNone: [ nil ].
	self assert: found equals: 50.
	
	self assert: (tree anySatisfy: [ :each | each > 60 ]).
	self deny: (tree anySatisfy: [ :each | each > 100 ])
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testCopy [
	
	| copiedTree |
	tree addAll: #(50 30 70).
	copiedTree := tree copy.
	
	self assert: copiedTree size equals: tree size.
	self assert: copiedTree asArray equals: tree asArray.

	copiedTree add: 99.
	self deny: (tree includes: 99).
	self assert: (copiedTree includes: 99)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testDoMethod [

	| result |
	tree addAll: #(50 30 70 20 40).
	
	result := OrderedCollection new.
	tree do: [ :each | result add: each ].
	
	self assert: result asArray equals: #(20 30 40 50 70)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testDuplicateHandling [

	tree addAll: #( 42 42 50 ).

	self assert: tree size equals: 2.

	self assert: (tree includes: 42).
	self assert: (tree includes: 50)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testElementsGreaterThan [

	| result |
	tree addAll: #(50 30 70 20 40 60 80).
	
	result := tree elementsGreaterThan: 45.
	self assert: result asArray equals: #(50 60 70 80).
	
	result := tree elementsGreaterThan: 80.
	self assert: result isEmpty.
	
	result := tree elementsGreaterThan: 10.
	self assert: result asArray equals: #(20 30 40 50 60 70 80)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testElementsLessThan [

	| result |
	tree addAll: #(50 30 70 20 40 60 80).
	
	result := tree elementsLessThan: 45.
	self assert: result asArray equals: #(20 30 40).
	
	result := tree elementsLessThan: 20.
	self assert: result isEmpty.
	
	result := tree elementsLessThan: 90.
	self assert: result asArray equals: #(20 30 40 50 60 70 80)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testEmpty [

	self assert: tree isEmpty.
	self assert: tree size equals: 0
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testEmptyTreeOperations [

		| result |
	self assert: tree isEmpty.
	self assert: tree findMin isNil.
	self assert: tree findMax isNil.
	self deny: (tree includes: 42).

	result := tree collect: [ :each | each * 2 ].
	self assert: result isEmpty.
	
	self deny: (tree anySatisfy: [ :each | true ])
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testFirstLast [

	tree addAll: #(50 30 70 20 80).
	self assert: tree first equals: 20.
	self assert: tree last equals: 80.
	self assert: CTBinarySearchTree new first isNil.
	self assert: CTBinarySearchTree new last isNil
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testHeight [

	self assert: tree height equals: 0.
	
	tree add: 50.
	self assert: tree height equals: 1.
	
	tree addAll: #(30 70).
	self assert: tree height equals: 2
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testInOrderTraversal [

		| result |
	tree addAll: #(50 30 70 20 40).
	
	result := OrderedCollection new.
	tree inOrderDo: [ :each | result add: each ].
	
	self assert: result asArray equals: #(20 30 40 50 70)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testIncludes [

	tree addAll: #(50 30 70 20 40).
	
	self assert: (tree includes: 50).
	self assert: (tree includes: 30).
	self deny: (tree includes: 99).
	self deny: (tree includes: 25)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testIsLeaf [

	tree add: 50.
	self assert: tree root isLeaf.
	
	tree add: 30.
	self deny: tree root isLeaf.
	self assert: tree root left isLeaf
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testNegativeNumbersTree [
	
		| result |
	tree addAll: #(-10 -5 0 5 10).
	
	self assert: tree findMin equals: -10.
	self assert: tree findMax equals: 10.
	result := tree asArray.
	self assert: result equals: #(-10 -5 0 5 10)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testPostOrderTraversal [

	| result |
	tree addAll: #( 50 30 70 20 ).

	result := OrderedCollection new.
	tree postOrderDo: [ :each | result add: each ].

	self assert: result last equals: 50.
	self assert: result asArray equals: #( 20 30 70 50 )
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testPreOrderTraversal [

	| result |
	tree addAll: #( 50 30 70 20 ).

	result := OrderedCollection new.
	tree preOrderDo: [ :each | result add: each ].
	self assert: result first equals: 50.
	self assert: result asArray equals: #(50 30 20 70)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testPredecessorSuccessorWithNonExistentElement [

	tree addAll: #( 50 30 70 20 40 60 80 ).
	
	self assert: (tree predecessorOf: 35) equals: 30.
	self assert: (tree successorOf: 35) equals: 40
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testPredecessors [

	tree addAll: #( 50 30 70 20 40 60 80 ).

	self assert: (tree predecessorOf: 50) equals: 40.
	self assert: (tree predecessorOf: 30) equals: 20.
	self assert: (tree predecessorOf: 20) isNil
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRangeQuery [

	| result temp |
	tree addAll: #( 50 30 70 20 40 60 80 ).

	result := tree elementsFrom: 35 to: 65.
	temp := result  asArray.
	self assert: result size equals: 3.
	self assert: temp equals: #(40 50 60).

	"Test edge cases"
	result := tree elementsFrom: 10 to: 15.
	self assert: result isEmpty.

	result := tree elementsFrom: 15 to: 5. "Invalid range"
	self assert: result isEmpty
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRemoveLeafNode [

	tree addAll: #(50 30 70 20).
	
	tree remove: 20.
	self assert: tree size equals: 3.
	self deny: (tree includes: 20)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRemoveNodeWithOneChild [

	tree addAll: #( 50 30 20 ).

	tree remove: 30.
	self assert: tree size equals: 2.
	self deny: (tree includes: 30).
	self assert: (tree includes: 20)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRemoveNodeWithTwoChildren [

	tree addAll: #(50 30 70 20 40).
	
	tree remove: 30.
	self assert: tree size equals: 4.
	self deny: (tree includes: 30)
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRemoveNonExistentElement [

		| result |
		
	tree addAll: #(50 30 70).
	result := tree remove: 99 ifAbsent: [ #notFound ].
	self assert: result equals: #notFound.
	self assert: tree size equals: 3.
	
	self should: [ tree remove: 99 ] raise: Error
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testRemoveRoot [
	"Root with no children"

	tree add: 50.
	tree remove: 50.
	self assert: tree isEmpty.

	"Root with two children"
	tree clear.
	tree addAll: #( 50 30 70 20 40 60 80 ).
	tree remove: 50.
	self assert: tree size equals: 6.
	self deny: (tree includes: 50).
	
	self assert: (tree includes: 60).
	self assert: tree root contents equals: 60
]

{ #category : 'tests' }
CTBinarySearchTreeTest >> testSuccessors [ 

		tree addAll: #(50 30 70 20 40 60 80).

	self assert: (tree successorOf: 50) equals: 60.
	self assert: (tree successorOf: 70) equals: 80.
	self assert: (tree successorOf: 80) isNil.
]
