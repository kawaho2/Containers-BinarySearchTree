"CTBinarySearchTree bulk serialization utilities"

CTBinarySearchTree>>asArray
    "Return an OrderedCollection of values in sorted order."
    | result |
    result := OrderedCollection new.
    self do: [:value | result add: value ].
    ^ result.

CTBinarySearchTree class>>fromArray: anArray
    "Construct a BST by inserting all elements from anArray (preserves order of insertion)."
    | tree |
    tree := self new.
    anArray do: [:v | tree add: v ].
    ^ tree.

CTBinarySearchTree class>>fromSortedArrayBalanced: sortedArray
    "Create a balanced BST from a sorted array using recursive median insertion (good for demos)."
    | tree |
    tree := self new.
    (self recursiveBuild: sortedArray into: tree).
    ^ tree.

CTBinarySearchTree class>>recursiveBuild: sortedArray into: tree
    | mid left right |
    sortedArray isEmpty ifTrue: [ ^ nil ].
    mid := sortedArray size // 2.
    left := sortedArray copyFrom: 1 to: mid.
    right := (mid + 2 <= sortedArray size) ifTrue: [ sortedArray copyFrom: (mid + 2) to: sortedArray size ] ifFalse: [ #() ].
    tree add: (sortedArray at: mid + 1).
    (left size > 0) ifTrue: [ self recursiveBuild: left into: tree ].
    (right size > 0) ifTrue: [ self recursiveBuild: right into: tree ].
