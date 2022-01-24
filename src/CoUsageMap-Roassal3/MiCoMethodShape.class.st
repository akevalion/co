"
TODO
"
Class {
	#name : #MiCoMethodShape,
	#superclass : #RSComposite,
	#category : #'CoUsageMap-Roassal3'
}

{ #category : #accessing }
MiCoMethodShape >> color: aColor [
	self children size > 1 
		ifTrue: [ self children second color: aColor ]
		ifFalse: [ super color: aColor ]
]
