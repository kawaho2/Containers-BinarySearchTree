"CTBinarySearchTree ASCII pretty printer"

CTBinarySearchTree>>asciiTreeString
    "Return a multi-line string showing the tree structure in ASCII."
    | lines |
    self root ifNil: [ ^ '' ].
    lines := OrderedCollection new.
    (self root asciiLinesInto: lines withPrefix: '').
    ^ lines joinSeparatedBy: String cr.

CTBinarySearchTreeNode>>asciiLinesInto: lines withPrefix: prefix
    "Append ASCII lines representing subtree with given prefix.
    This method should be added to node class."
    | label left right newPrefix |
    label := (self value printString).
    lines add: (prefix , label).
    left := self left.
    right := self right.
    (left isNil and: [ right isNil ]) ifTrue: [ ^ self ].
    newPrefix := prefix , '  '.
    right ifNotNil: [ right asciiLinesInto: lines withPrefix: newPrefix ].
    left ifNotNil: [ left asciiLinesInto: lines withPrefix: newPrefix ].
    ^ self.
