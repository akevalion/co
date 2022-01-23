"
TODO
"
Class {
	#name : #MiCoUsageBrowser,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'coUsageMap',
		'classModel'
	],
	#category : #'MooseIDE-CoUsageMap-Browser'
}

{ #category : #'instance creation' }
MiCoUsageBrowser class >> open [
	<script>
	^ super open
]

{ #category : #accessing }
MiCoUsageBrowser class >> title [ 
	^ 'Co usage map'
]

{ #category : #accessing }
MiCoUsageBrowser class >> windowSize [
	^ 800@600
]

{ #category : #testing }
MiCoUsageBrowser >> canFollowEntity: anEntity [
	^ anEntity isClass
]

{ #category : #accessing }
MiCoUsageBrowser >> classModel [

	^ classModel
]

{ #category : #accessing }
MiCoUsageBrowser >> classModel: anObject [

	classModel := anObject
]

{ #category : #actions }
MiCoUsageBrowser >> followEntity: anEntity [
	classModel := anEntity.
	coUsageMap run.
]

{ #category : #initialization }
MiCoUsageBrowser >> initializeLayout [
	self layout: (SpBoxLayout newLeftToRight
		add: coUsageMap;
		yourself)
]

{ #category : #initialization }
MiCoUsageBrowser >> initializePresenters [
	coUsageMap := self instantiate: MiCoUsageMapVisualization.
	self initializeLayout.
	
]
