"
TODO
"
Class {
	#name : #MiCoUsageMapMooseBuilder,
	#superclass : #MiCoUsageMapBuilder,
	#category : #'MooseIDE-CoUsageMap-Roassal3'
}

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
			yourself ] as: OrderedCollection
]

{ #category : #initialization }
MiCoUsageMapMooseBuilder >> initializeMethods [
	miMethods := methods collect: [ :met | 
		MiCoMethod new
			name: met name;
			rawObject: met;
			yourself ] as: OrderedCollection.
]
