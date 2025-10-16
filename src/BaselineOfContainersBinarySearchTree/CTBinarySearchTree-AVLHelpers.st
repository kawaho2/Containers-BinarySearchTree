"CTBinarySearchTree - AVL rotation helpers"

CTBinarySearchTree>>rotateLeft: node
    "Return the new subtree root after a left rotation at node.
    Assumes node has a non-nil right child. Updates parent links."
    | r |
    r := node right.
    (r isNil) ifTrue: [ ^ node ].
    node right: r left.
    (r left notNil) ifTrue: [ r left parent: node ].
    r parent: node parent.
    (node parent ifNotNil: [ (node parent left = node) ifTrue: [ node parent left: r ] ifFalse: [ node parent right: r ] ]).
    r left: node.
    node parent: r.
    ^ r.

CTBinarySearchTree>>rotateRight: node
    "Return the new subtree root after a right rotation at node."
    | l |
    l := node left.
    (l isNil) ifTrue: [ ^ node ].
    node left: l right.
    (l right notNil) ifTrue: [ l right parent: node ].
    l parent: node parent.
    (node parent ifNotNil: [ (node parent left = node) ifTrue: [ node parent left: l ] ifFalse: [ node parent right: l ] ]).
    l right: node.
    node parent: l.
    ^ l.
