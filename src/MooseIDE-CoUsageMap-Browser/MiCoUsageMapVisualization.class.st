"
TODO
"
Class {
	#name : #MiCoUsageMapVisualization,
	#superclass : #MiAbstractVisualization,
	#instVars : [
		'legendTag'
	],
	#category : #'MooseIDE-CoUsageMap-Browser'
}

{ #category : #brokerage }
MiCoUsageMapVisualization >> consume: aTag [
	legendTag removeOldLegend.
	legendTag tagsFromMooseModel: self owner classModel mooseModel.
	legendTag build.
	
]

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
	legendTag := v legendTag.
	self consume: nil.
	v build.
	
]
