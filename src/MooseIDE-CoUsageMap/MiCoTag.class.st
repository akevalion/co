"
TODO
"
Class {
	#name : #MiCoTag,
	#superclass : #Object,
	#instVars : [
		'label',
		'color',
		'references'
	],
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #adding }
MiCoTag >> addReference: aMiCoObject [
	references add: aMiCoObject
]

{ #category : #accessing }
MiCoTag >> color [

	^ color
]

{ #category : #accessing }
MiCoTag >> color: anObject [

	color := anObject
]

{ #category : #initialization }
MiCoTag >> initialize [
	super initialize.
	references := OrderedCollection new: 5.
	
]

{ #category : #accessing }
MiCoTag >> label [

	^ label
]

{ #category : #accessing }
MiCoTag >> label: anObject [

	label := anObject
]

{ #category : #public }
MiCoTag >> numberOfReferences [
	^ references size
]
