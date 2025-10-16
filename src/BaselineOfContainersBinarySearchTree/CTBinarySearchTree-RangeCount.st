"CTBinarySearchTree range count utility"

CTBinarySearchTree>>countBetween: low and: high
    "Count number of elements in [low,high] without allocating collection."
    | count |
    count := 0.
    (self root ifNil: [ ^ 0 ]).
    self root countBetween: low and: high into: [:v | count := count + 1 ].
    ^ count.

CTBinarySearchTreeNode>>countBetween: low and: high into: incrementBlock
    (self left ifNotNil and: [ self value > low ]) ifTrue: [ self left countBetween: low and: high into: incrementBlock ].
    ((self value >= low) and: [ self value <= high ]) ifTrue: [ incrementBlock value: self value ].
    (self right ifNotNil and: [ self value < high ]) ifTrue: [ self right countBetween: low and: high into: incrementBlock ].
