"CTBinarySearchTree-ExtrasTest test class"

TestCase subclass: #CTBinarySearchTreeExtrasTest
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'ContainersBinarySearchTree-Tests'.

CTBinarySearchTreeExtrasTest>>testHeightAndPrettyPrint
    | t |
    t := CTBinarySearchTree new.
    self assert: (t height = 0).
    t addAll: #(50 30 70 20 40 60 80).
    self assert: (t height = 3).
    self assert: (t isBalanced).

CTBinarySearchTreeExtrasTest>>testKthSmallest
    | t |
    t := CTBinarySearchTree new.
    t addAll: #(50 30 70 20 40 60 80).
    self assert: (t kthSmallest: 1 = 20).
    self assert: (t kthSmallest: 4 = 50).
    self assert: (t kthSmallest: 7 = 80).
    self deny: (t kthSmallest: 8).
