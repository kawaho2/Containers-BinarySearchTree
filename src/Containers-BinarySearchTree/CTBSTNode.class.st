"
I represent a node in a Binary Search Tree containing actual data.

I hold a value and references to left and right child nodes, maintaining the BST invariant where left child < my contents < right child.

I implement all tree operations recursively, delegating to my children when appropriate. My children are never nil - they are either other CTBSTNode instances or CTBSTNillNode instances.

"
Class {
	#name : 'CTBSTNode',
	#superclass : 'CTBSTAbstractNode',
	#instVars : [
		'contents',
		'left',
		'right'
	],
	#category : 'Containers-BinarySearchTree',
	#package : 'Containers-BinarySearchTree'
}

{ #category : 'adding' }
CTBSTNode >> addChild: anObject [

	anObject < contents
		ifTrue: [ self left: (left addChild: anObject) ]
		ifFalse: [
			anObject > contents ifTrue: [ self right: (right addChild: anObject) ] ].
	^ self
]

{ #category : 'accessing' }
CTBSTNode >> contents [

	^ contents
]

{ #category : 'accessing' }
CTBSTNode >> contents: anObject [

	contents := anObject
]

{ #category : 'enumerating' }
CTBSTNode >> elementsFrom: min to: max into: aCollection [

	contents > min ifTrue: [
		left elementsFrom: min to: max into: aCollection ].
	(contents between: min and: max) ifTrue: [ aCollection add: contents ].

	contents < max ifTrue: [
		right elementsFrom: min to: max into: aCollection ]
]

{ #category : 'enumerating' }
CTBSTNode >> elementsGreaterThan: anObject into: aCollection [

	"If current node is greater than target, check left subtree and include current"
	contents > anObject ifTrue: [
		left elementsGreaterThan: anObject into: aCollection.
		aCollection add: contents ].
	"Always check right subtree"
	right elementsGreaterThan: anObject into: aCollection
]

{ #category : 'enumerating' }
CTBSTNode >> elementsLessThan: anObject into: aCollection [

	left elementsLessThan: anObject into: aCollection.
	contents < anObject ifFalse: [ ^ self ].
	aCollection add: contents.
	right elementsLessThan: anObject into: aCollection
]

{ #category : 'searching' }
CTBSTNode >> findMax [
^ self findMaxNode contents
]

{ #category : 'searching' }
CTBSTNode >> findMaxNode [

	^ right isEmpty
		ifTrue: [ self ]
		ifFalse: [ right findMaxNode ]
]

{ #category : 'searching' }
CTBSTNode >> findMin [

	^ self findMinNode contents
]

{ #category : 'searching' }
CTBSTNode >> findMinNode [

	^ left isEmpty
		ifTrue: [ self ]
		ifFalse: [ left findMinNode ]
]

{ #category : 'accessing' }
CTBSTNode >> height [

	^ 1 + (left height max: right height)
]

{ #category : 'enumerating' }
CTBSTNode >> inOrderDo: aBlock [

	left inOrderDo: aBlock.
	aBlock value: contents.
	right inOrderDo: aBlock
]

{ #category : 'initialization' }
CTBSTNode >> initialize [

	super initialize.
	left := CTBSTNilNode new parent: self.
	right := CTBSTNilNode new parent: self
]

{ #category : 'testing' }
CTBSTNode >> isEmpty [

	^ false
]

{ #category : 'testing' }
CTBSTNode >> isLeaf [

	^ left isEmpty and: [ right isEmpty ]
]

{ #category : 'accessing' }
CTBSTNode >> left [

	^ left
]

{ #category : 'accessing' }
CTBSTNode >> left: aNode [

	left := aNode.
	aNode parent: self
]

{ #category : 'enumerating' }
CTBSTNode >> postOrderDo: aBlock [

	left postOrderDo: aBlock.
	right postOrderDo: aBlock.
	aBlock value: contents 
]

{ #category : 'enumerating' }
CTBSTNode >> preOrderDo: aBlock [

	aBlock value: contents.
	left preOrderDo: aBlock.
	right preOrderDo: aBlock
]

{ #category : 'searching' }
CTBSTNode >> predecessorOf: anObject [
	
		| rightResult |
	"Find the largest element smaller than anObject"
	
	anObject <= contents ifTrue: [
		^ left predecessorOf: anObject ].
	
	"Current node is potential predecessor, check right subtree for better one"
	rightResult := right predecessorOf: anObject.
	^ rightResult ifNil: [ contents ] ifNotNil: [ rightResult ]
]

{ #category : 'removing' }
CTBSTNode >> removeThisNode [
	"Remove this specific node and return its replacement.
	The caller is responsible for linking the replacement into the tree."
	| successor |
	"Case 1 & 2: Leaf or single child. Return the non-empty child or the nil node."
	left isEmpty ifTrue: [ ^ right ].
	right isEmpty ifTrue: [ ^ left ].

	"Case 3: Two children. Replace contents with inorder successor's contents,
	then remove the successor node from the right subtree."
	successor := right findMinNode.
	self contents: successor contents.
	self right: (right removeValue: successor contents).
	^ self
]

{ #category : 'removing' }
CTBSTNode >> removeValue: anObject [
	"Find the node with anObject and remove it, returning the new root of this subtree."
	anObject < contents ifTrue: [
		self left: (left removeValue: anObject).
		^ self ].

	anObject > contents ifTrue: [
		self right: (right removeValue: anObject).
		^ self ].

	"Found the node to remove. `removeThisNode` will return the replacement."
	^ self removeThisNode
]

{ #category : 'accessing' }
CTBSTNode >> right [

	^ right 
]

{ #category : 'accessing' }
CTBSTNode >> right: aNode [

	right := aNode.
	aNode parent: self
]

{ #category : 'accessing' }
CTBSTNode >> search: anObject [

	contents = anObject ifTrue: [ ^ contents ].
	^ anObject < contents
		ifTrue: [ left search: anObject ]
		ifFalse: [ right search: anObject ]
]

{ #category : 'accessing' }
CTBSTNode >> size [

	^ 1 + left size + right size
]

{ #category : 'searching' }
CTBSTNode >> successorOf: anObject [

	| leftResult |
	"Find the smallest element larger than anObject"
	
	anObject >= contents ifTrue: [
		^ right successorOf: anObject ].
	
	"Current node is potential successor, check left subtree for better one"
	leftResult := left successorOf: anObject.
	^ leftResult ifNil: [ contents ] ifNotNil: [ leftResult ]
]

{ #category : 'testing' }
CTBSTNode >> validateBSTProperty [

	"Check if BST property holds: left < node < right"
	^ self validateBSTPropertyWithMin: nil max: nil
]

{ #category : 'private' }
CTBSTNode >> validateBSTPropertyWithMin: min max: max [

	(min notNil and: [ contents < min ]) ifTrue: [ ^ false ].
	(max notNil and: [ contents > max ]) ifTrue: [ ^ false ].

	^ (left validateBSTPropertyWithMin: min max: contents) and: [
		right validateBSTPropertyWithMin: contents max: max ]

]
