"
TODO
"
Class {
	#name : #MiCoUsageMapMooseBuilder,
	#superclass : #MiCoUsageMapBuilder,
	#instVars : [
		'application'
	],
	#category : #'MooseIDE-CoUsageMap-Browser'
}

{ #category : #accessing }
MiCoUsageMapMooseBuilder >> application [

	^ application
]

{ #category : #accessing }
MiCoUsageMapMooseBuilder >> application: anObject [

	application := anObject
]

{ #category : #default }
MiCoUsageMapMooseBuilder >> defaultTester [
	^ MiCoMooseMethodAttributeTester new
]

{ #category : #initialization }
MiCoUsageMapMooseBuilder >> initializeAttributes [
	miAttributes := attributes collect: [ :att |
		MiCoAttribute new
			name: att name;
			rawObject: att;
			application: self application;
			yourself ] as: OrderedCollection
]

{ #category : #initialization }
MiCoUsageMapMooseBuilder >> initializeMethods [
	miMethods := methods collect: [ :met | 
		MiCoMethod new
			name: met name;
			rawObject: met;
			application: self application;
			yourself ] as: OrderedCollection.
]
