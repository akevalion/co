"
TODO
"
Class {
	#name : #MiCoUsageMapVisualization,
	#superclass : #MiAbstractVisualization,
	#category : #'MooseIDE-CoUsageMap-Browser'
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
	| model v tags conflictTag |
	super run.
	model := self owner classModel.
	tags := model mooseModel allTags sorted: [:a :b| a name < b name].
	conflictTag := model mooseModel tagNamed: 'Need work'.

	v := MiCoUsageMapMooseBuilder new.
	v container: self canvas.
	v attributes: model attributes.
	v methods: model methods.
	v legendTag
		conflictTag: (MiCoTag new
			name: conflictTag name;
			color: conflictTag color;
			description: conflictTag description).
	tags 
		reject: [ :tag | tag = conflictTag ]
		thenDo: [ :tag |
			v legendTag addTag: (MiCoTag new
				name: tag name;
				color: tag color;
				description: tag description) ].
	v build.
	
]
