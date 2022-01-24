"
TODO
"
Class {
	#name : #MiCo75PercentageMarkStrategy,
	#superclass : #MiCoMarkStrategy,
	#category : #'CoUsageMap-Model'
}

{ #category : #hooks }
MiCo75PercentageMarkStrategy >> computeTag [
	| biggerGroup threshold tag |
	biggerGroup := #().
	tag := nil.
	threshold := 0.75.
	self groupsByTag keysAndValuesDo: [ :groupTag :group | 
		group size > biggerGroup size ifTrue: [
			tag := groupTag.
			biggerGroup := group ] ].
	^ (biggerGroup size / self method usedAttributes size) > threshold 
		ifTrue: [ tag ]
		ifFalse: [ nil ]
]

{ #category : #hooks }
MiCo75PercentageMarkStrategy >> order [
	^ 1
]
