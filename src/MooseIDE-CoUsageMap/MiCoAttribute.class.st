"
Model for attributes
"
Class {
	#name : #MiCoAttribute,
	#superclass : #Object,
	#instVars : [
		'name',
		'usedInMethods'
	],
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #accessing }
MiCoAttribute >> name [

	^ name
]

{ #category : #accessing }
MiCoAttribute >> name: anObject [

	name := anObject
]

{ #category : #accessing }
MiCoAttribute >> usedInMethods [

	^ usedInMethods
]

{ #category : #accessing }
MiCoAttribute >> usedInMethods: anObject [

	usedInMethods := anObject
]
