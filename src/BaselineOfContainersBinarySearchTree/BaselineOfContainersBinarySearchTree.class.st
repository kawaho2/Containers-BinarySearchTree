"
I represent Baseline of Binary Search Tree
"
Class {
	#name : 'BaselineOfContainersBinarySearchTree',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersBinarySearchTree',
	#package : 'BaselineOfContainersBinarySearchTree'
}

{ #category : 'baselines' }
BaselineOfContainersBinarySearchTree >> baseline: spec [
    <baseline>
    spec for: #common do: [
            spec package: 'Containers-BinarySearchTree'.
            spec
                package: 'Containers-BinarySearchTree-Tests'
                with: [ spec requires: #( 'Containers-BinarySearchTree' ) ] ]


]
