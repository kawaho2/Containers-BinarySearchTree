"CTBinarySearchTreeNode helper methods"

CTBinarySearchTreeNode>>height
    "Height of subtree rooted at this node. Leaf => 1."
    ^ 1 + (((self left ifNil: [ 0 ]) max: (self right ifNil: [ 0 ]))).

CTBinarySearchTreeNode>>subtreeSize
    "Return cached subtree size if present, else compute. To use cached counts maintain updates in insert/remove."
    (self respondsTo: #subtreeSizeVar) ifTrue: [ ^ self subtreeSizeVar ].
    ^ 1 + ((self left ifNotNil: [ self left subtreeSize ]) ifNil: [ 0 ]) + ((self right ifNotNil: [ self right subtreeSize ]) ifNil: [ 0 ]).

CTBinarySearchTreeNode>>isBalanced
    "True if subtree is balanced and both subtrees recursively balanced."
    | lh rh |
    lh := (self left ifNil: [ 0 ]) ifNotNil: [ self left height ].
    rh := (self right ifNil: [ 0 ]) ifNotNil: [ self right height ].
    ((lh - rh) abs <= 1)
        and: [ (self left ifNotNil: [ self left isBalanced ]) ifNil: [ true ] ]
        and: [ (self right ifNotNil: [ self right isBalanced ]) ifNil: [ true ] ].

CTBinarySearchTreeNode>>inOrderDo: aBlock
    (self left ifNotNil: [ self left inOrderDo: aBlock ]).
    aBlock value: self.
    (self right ifNotNil: [ self right inOrderDo: aBlock ]).

CTBinarySearchTreeNode>>toDotOn: stream
    "Append DOT lines for this node and its children (graph edges)."
    | nodeName |
    nodeName := 'n', (self identityHash asString).
    stream nextPutAll: '  ', nodeName, ' [label="', (self value printString), '"];'; cr.
    (self left ifNotNil: [
        stream nextPutAll: '  ', nodeName, ' -> n', (self left identityHash asString), ';'; cr.
        self left toDotOn: stream ]).
    (self right ifNotNil: [
        stream nextPutAll: '  ', nodeName, ' -> n', (self right identityHash asString), ';'; cr.
        self right toDotOn: stream ]).

CTBinarySearchTreeNode>>successor
    "Return the node which is the in-order successor of this node, or nil."
    | n |
    (self right ifNotNil: [
        n := self right.
        [ n left notNil ] whileTrue: [ n := n left ].
        ^ n ]).
    n := self.
    [ n parent notNil and: [ n parent right = n ] ] whileTrue: [ n := n parent ].
    ^ n parent.

CTBinarySearchTreeNode>>predecessor
    | n |
    (self left ifNotNil: [
        n := self left.
        [ n right notNil ] whileTrue: [ n := n right ].
        ^ n ]).
    n := self.
    [ n parent notNil and: [ n parent left = n ] ] whileTrue: [ n := n parent ].
    ^ n parent.

CTBinarySearchTreeNode>>elementsBetween: low and: high into: collection
    "Append values within [low,high] (assumes values are Comparable via <= and >=)."
    (self left ifNotNil and: [ (self value > low) ]) ifTrue: [ self left elementsBetween: low and: high into: collection ].
    ( (self value >= low) and: [ self value <= high ]) ifTrue: [ collection add: self value ].
    (self right ifNotNil and: [ (self value < high) ]) ifTrue: [ self right elementsBetween: low and: high into: collection ].
