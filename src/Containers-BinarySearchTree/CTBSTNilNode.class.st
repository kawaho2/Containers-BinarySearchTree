"
I represent an empty node in a Binary Search Tree using the Null Object pattern.

I provide default 'do nothing' behavior for all tree operations, eliminating the need for nil checks throughout the tree algorithms. This makes the code cleaner and prevents null pointer errors.

When elements are added to me, I create and return a new CTBSTNode containing the element, effectively growing the tree.
"
Class {
	#name : 'CTBSTNilNode',
	#superclass : 'CTBSTAbstractNode',
	#category : 'Containers-BinarySearchTree',
	#package : 'Containers-BinarySearchTree'
}

{ #category : 'adding' }
CTBSTNilNode >> addChild: anObject [

	^ CTBSTNode new
		contents: anObject;
		parent: self parent;
		yourself
]

{ #category : 'accessing' }
CTBSTNilNode >> contents [

	^ nil
]

{ #category : 'accessing' }
CTBSTNilNode >> contents: anObject [

	"Do nothing for nil node"
]

{ #category : 'enumerating' }
CTBSTNilNode >> elementsFrom: min to: max into: aCollection [

	"Do nothing for nill node"
]

{ #category : 'enumerating' }
CTBSTNilNode >> elementsGreaterThan: anObject into: aCollection [

	"Do nothing for nill node"
]

{ #category : 'enumerating' }
CTBSTNilNode >> elementsLessThan: anObject into: aCollection [

	"Do nothing for nill node"
]

{ #category : 'searching' }
CTBSTNilNode >> findMax [

	^ nil
]

{ #category : 'searching' }
CTBSTNilNode >> findMaxNode [

	^ self
]

{ #category : 'searching' }
CTBSTNilNode >> findMin [

	^ nil
]

{ #category : 'searching' }
CTBSTNilNode >> findMinNode [

	^ self
]

{ #category : 'accessing' }
CTBSTNilNode >> height [

	^ 0
]

{ #category : 'enumerating' }
CTBSTNilNode >> inOrderDo: aBlock [

	"Do nothing for nil node"
]

{ #category : 'testing' }
CTBSTNilNode >> isEmpty [

	^ true
]

{ #category : 'testing' }
CTBSTNilNode >> isLeaf [

	^ false
]

{ #category : 'enumerating' }
CTBSTNilNode >> postOrderDo: aBlock [

	"Do nothing for nill node"
]

{ #category : 'enumerating' }
CTBSTNilNode >> preOrderDo: aBlock [

	"Do nothing for nill node"
]

{ #category : 'searching' }
CTBSTNilNode >> predecessorOf: anObject [

	^ nil
]

{ #category : 'removing' }
CTBSTNilNode >> removeValue: anObject [

	"Element not found - return self unchanged"
	^ self
]

{ #category : 'accessing' }
CTBSTNilNode >> search: anObject [

	^ nil
]

{ #category : 'accessing' }
CTBSTNilNode >> size [

	^ 0
]

{ #category : 'searching' }
CTBSTNilNode >> successorOf: anObject [

	^ nil
]

{ #category : 'testing' }
CTBSTNilNode >> validateBSTProperty [

	^ true
]

{ #category : 'private' }
CTBSTNilNode >> validateBSTPropertyWithMin: min max: max [

	^ true
]
