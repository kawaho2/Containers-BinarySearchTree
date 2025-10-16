"CTBinarySearchTree - external iterator class and factory"

Object subclass: #CTBSTInOrderIterator
    instanceVariableNames: 'stack current'
    classVariableNames: ''
    poolDictionaries: ''
    package: 'ContainersBinarySearchTree-Iteration'.

CTBSTInOrderIterator>>initializeFrom: root
    stack := OrderedCollection new.
    current := root.
    self pushLefts: current.
    ^ self.

CTBSTInOrderIterator>>pushLefts: node
    [ node notNil ] whileTrue: [ stack add: node. node := node left ].

CTBSTInOrderIterator>>hasNext
    ^ (stack notEmpty).

CTBSTInOrderIterator>>next
    | node result |
    self hasNext ifFalse: [ self error: 'No next element' ].
    node := stack removeLast.
    result := node value.
    (node right notNil) ifTrue: [ self pushLefts: node right ].
    ^ result.

CTBinarySearchTree>>iterator
    "Return a new in-order iterator for consumers."
    ^ (CTBSTInOrderIterator new initializeFrom: self root).
