"
Model for attributes
"
Class {
	#name : #MiCoAttribute,
	#superclass : #MiCoTaggedObject,
	#instVars : [
		'usedInMethods'
	],
	#category : #'CoUsageMap-Model'
}

{ #category : #converting }
MiCoAttribute >> asStringForMethod: aMicoMethod [
	^ String streamContents: [:s | self printForMethod: aMicoMethod on: s] 
]

{ #category : #initialization }
MiCoAttribute >> initialize [
	super initialize.
	usedInMethods := Dictionary new.
]

{ #category : #public }
MiCoAttribute >> method: aMiCoMethod counter: aNumber [
	usedInMethods at: aMiCoMethod put: aNumber
]

{ #category : #public }
MiCoAttribute >> numberOfUsesOn: aMiCoMethod [
	^ usedInMethods at: aMiCoMethod
]

{ #category : #converting }
MiCoAttribute >> printForMethod: aMicoMethod on: stream [
	| n numberOfUsers |
	stream 
		nextPutAll: 'Accesses for ';
		nextPutAll: name;
		nextPutAll: ':';
		crlf; crlf.
	n := self numberOfUsesOn: aMicoMethod.
	n printOn: stream.
	stream 
		nextPutAll: ' access from this method(';
		nextPutAll: aMicoMethod name;
		nextPutAll: ')'.
	numberOfUsers := self usedInMethods size - 1.
	numberOfUsers <= 0 ifTrue: [ ^ self ].
	n := self usedInMethods sum - n.
	n <= 0 ifTrue: [ ^ self ].
	stream crlf.
	n printOn: stream.
	
	stream nextPutAll: ' access from '.
	numberOfUsers printOn: stream.
	stream nextPutAll: ' local method'.
	numberOfUsers > 1 
		ifTrue: [ stream nextPutAll: 's' ]
	
	
]

{ #category : #accessing }
MiCoAttribute >> usedInMethods [
	^ usedInMethods
]

{ #category : #accessing }
MiCoAttribute >> usedInMethods: aCollection [
	usedInMethods := aCollection
]
