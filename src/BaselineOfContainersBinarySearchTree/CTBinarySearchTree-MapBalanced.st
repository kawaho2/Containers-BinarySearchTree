"CTBinarySearchTree mapping to a balanced tree"

CTBinarySearchTree>>mapBalanced: aBlock
    "Return a new CTBinarySearchTree containing aBlock value applied to each element, balanced."
    | arr mapped sorted unique |
    arr := self asArray.
    mapped := arr collect: aBlock.
    "optional: remove duplicates and sort"
    sorted := (mapped asSet asSortedCollection).
    ^ (self class fromSortedArrayBalanced: sorted).
