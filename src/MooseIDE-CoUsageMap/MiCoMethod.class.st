"
Model for methods
"
Class {
	#name : #MiCoMethod,
	#superclass : #Object,
	#instVars : [
		'selector',
		'sourceCode',
		'usedAttributes'
	],
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #accessing }
MiCoMethod >> selector [

	^ selector
]

{ #category : #accessing }
MiCoMethod >> selector: anObject [

	selector := anObject
]

{ #category : #accessing }
MiCoMethod >> sourceCode [

	^ sourceCode
]

{ #category : #accessing }
MiCoMethod >> sourceCode: anObject [

	sourceCode := anObject
]

{ #category : #accessing }
MiCoMethod >> usedAttributes [

	^ usedAttributes
]

{ #category : #accessing }
MiCoMethod >> usedAttributes: anObject [

	usedAttributes := anObject
]
