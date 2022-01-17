"
TODO
"
Class {
	#name : #MiCoTaggedObject,
	#superclass : #Object,
	#instVars : [
		'tag'
	],
	#category : #'MooseIDE-CoUsageMap-Model'
}

{ #category : #accessing }
MiCoTaggedObject >> tag [
	^ tag
]

{ #category : #accessing }
MiCoTaggedObject >> tag: aMiCoTag [
	tag ifNotNil: [ tag removeReference: self ].
	tag := aMiCoTag.
	tag ifNotNil: [ tag addReference: self ].
	
]
