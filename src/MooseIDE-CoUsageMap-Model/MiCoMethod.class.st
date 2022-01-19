"
Model for methods
"
Class {
	#name : #MiCoMethod,
	#superclass : #MiCoTaggedObject,
	#instVars : [
		'usedAttributes',
		'rawMethod'
	],
	#category : #'MooseIDE-CoUsageMap-Model'
}

{ #category : #adding }
MiCoMethod >> addAttribute: aMiCoAttribute [
	usedAttributes add: aMiCoAttribute
]

{ #category : #initialization }
MiCoMethod >> initialize [
	super initialize.
	usedAttributes := OrderedCollection new: 5.
]

{ #category : #accessing }
MiCoMethod >> rawMethod [
	^ rawMethod
]

{ #category : #accessing }
MiCoMethod >> rawMethod: anObject [
	rawMethod := anObject
]

{ #category : #accessing }
MiCoMethod >> usedAttributes [

	^ usedAttributes
]

{ #category : #accessing }
MiCoMethod >> usedAttributes: aCollection [
	usedAttributes := aCollection
]
