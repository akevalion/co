"
TODO
"
Class {
	#name : #MiCoTaggedObject,
	#superclass : #Object,
	#instVars : [
		'tag'
	],
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #accessing }
MiCoTaggedObject >> tag [
	^ tag
]

{ #category : #accessing }
MiCoTaggedObject >> tag: aMiCoTag [ 
	tag := aMiCoTag.
	tag addReference: self.
]
