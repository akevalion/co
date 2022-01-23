"
TODO
"
Class {
	#name : #MiCoUsageMapVisualization,
	#superclass : #MiAbstractVisualization,
	#category : #'MooseIDE-CoUsageMap-Roassal3'
}

{ #category : #highlighting }
MiCoUsageMapVisualization >> highlightShapes [
	^ #()
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initialize [
	super initialize.
	self script: [ :canvas | canvas ]
]

{ #category : #running }
MiCoUsageMapVisualization >> run [
	| model v |
	super run.
	model := self owner classModel.
	v := MiCoUsageMapMooseBuilder new.
	v container: self canvas.
	v attributes: model attributes.
	v methods: model methods.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	v build.
]
