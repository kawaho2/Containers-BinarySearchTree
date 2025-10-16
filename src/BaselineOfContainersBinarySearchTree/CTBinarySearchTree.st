"CTBinarySearchTree methods added: utilities, queries"

CTBinarySearchTree>>height
    "Return the height of the tree. Empty => 0, single-node => 1."
    ^ self root ifNil: [ 0 ] ifNotNil: [ self root height ].

CTBinarySearchTree>>size
    "Return the number of elements in the tree. If node sizes are cached this is O(1)."
    ^ self root ifNil: [ 0 ] ifNotNil: [ self root subtreeSize ifNotNil: [ self root subtreeSize ] ifNil: [ 
        | c |
        c := 0.
        self do: [:each | c := c + 1 ].
        ^ c ] ].

CTBinarySearchTree>>kthSmallest: k
    "Return the kth smallest element (1-based). If k out of range return nil.
    Uses subtreeSize on nodes if available for O(log n) selection."
    (k isKindOf: Integer) ifFalse: [ ^ nil ].
    (k <= 0) ifTrue: [ ^ nil ].
    self root ifNil: [ ^ nil ].
    | node |
    node := self root.
    [ node notNil ] whileTrue: [
        | leftSize |
        leftSize := (node left ifNotNil: [ node left subtreeSize ]) ifNil: [ 0 ].
        (leftSize + 1 = k) ifTrue: [ ^ node value ].
        (k <= leftSize) ifTrue: [ node := node left ] ifFalse: [ k := k - (leftSize + 1). node := node right ] ].
    ^ nil.

CTBinarySearchTree>>isBalanced
    "Return true if tree is height-balanced (difference ≤ 1 everywhere)."
    ^ self root ifNil: [ true ] ifNotNil: [ self root isBalanced ].

CTBinarySearchTree>>successorOf: anElement
    "Return the in-order successor value of anElement or nil."
    | node |
    node := self locateNodeFor: anElement.
    node ifNil: [ ^ nil ].
    ^ (node successor) ifNil: [ nil ] ifNotNil: [ (node successor) value ].

CTBinarySearchTree>>predecessorOf: anElement
    | node |
    node := self locateNodeFor: anElement.
    node ifNil: [ ^ nil ].
    ^ (node predecessor) ifNil: [ nil ] ifNotNil: [ (node predecessor) value ].

CTBinarySearchTree>>toDot
    "Return a Graphviz DOT string representing the tree. Useful for visual checks."
    | sb |
    sb := String streamContents: [:s |
        s nextPutAll: 'digraph BST {'; cr.
        s nextPutAll: '  node [shape=record];'; cr.
        (self root ifNotNil: [ self root toDotOn: s ]).
        s nextPutAll: '}' ].
    ^ sb contents.

CTBinarySearchTree>>prettyPrintByLevel
    "Return a readable String listing nodes level-by-level."
    | out q nextQ level |
    out := String new writeStream.
    (self root ifNil: [ ^ '' ]).
    q := OrderedCollection new.
    q add: self root.
    level := 0.
    [ q isEmpty ] whileFalse: [
        nextQ := OrderedCollection new.
        out nextPutAll: 'Level ', level asString, ': '.
        q do: [:n |
            out nextPutAll: (n value printString), ' '.
            (n left ifNotNil: [ nextQ add: n left ]).
            (n right ifNotNil: [ nextQ add: n right ]) ].
        out cr.
        q := nextQ.
        level := level + 1 ].
    ^ out contents.

CTBinarySearchTree>>elementsBetween: low and: high
    "Return an OrderedCollection of elements x where low <= x <= high (inclusive)."
    | out |
    out := OrderedCollection new.
    (self root ifNil: [ ^ out ]).
    self root elementsBetween: low and: high into: out.
    ^ out.
