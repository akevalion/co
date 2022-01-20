"
TODO
"
Class {
	#name : #MiCoMarkManager,
	#superclass : #RSInteraction,
	#instVars : [
		'coUsageMap',
		'menuInteraction'
	],
	#category : #'MooseIDE-CoUsageMap-Roassal3'
}

{ #category : #public }
MiCoMarkManager >> automaticColor [
	self coUsageMap miMethods 
		select: [ :met | met tag isNil ]
		thenDo:[:met | self automaticColorForMethod: met ].
]

{ #category : #public }
MiCoMarkManager >> automaticColorForMethod: aMiCoMethod [
	| groupsByTag conflictTag tag |
	groupsByTag := aMiCoMethod usedAttributes 
		groupedBy: [ :att | att tag ].
	conflictTag := self conflictTag.
	
	groupsByTag ifEmpty: [ "nothing to compare" ^ self ].
	groupsByTag size = 1 ifTrue: [ 
		tag := groupsByTag keys anyOne.
		tag ifNotNil:[ self setTag: tag onAttribute: aMiCoMethod ].
		^ self ].
	
	self setTag: conflictTag onAttribute: aMiCoMethod
	
]

{ #category : #accessing }
MiCoMarkManager >> coUsageMap [
	^ coUsageMap
]

{ #category : #accessing }
MiCoMarkManager >> coUsageMap: aMiCoCoUsageMapVisualization [
	coUsageMap := aMiCoCoUsageMapVisualization
]

{ #category : #accessing }
MiCoMarkManager >> conflictTag [
	^ self coUsageMap legendTag conflictTag
]

{ #category : #'building - menus' }
MiCoMarkManager >> createGlobalMenuOn: menu [
	(menu
		add: 'Automatic color methods'
			target: self
			selector: #automaticColor
			argumentList: #())
		icon: (self iconNamed: #smallPaint)
]

{ #category : #'building - menus' }
MiCoMarkManager >> createMenuOn: menu for: aShape [
	aShape isShape
		ifTrue: [ aShape model createMenuOn: menu markManager: self ]
		ifFalse: [ self createGlobalMenuOn: menu ].
	
]

{ #category : #'building - menus' }
MiCoMarkManager >> iconFormFor: aMiCoTag [
	^ (FormCanvas extent: 15 asPoint)
		fillColor: aMiCoTag color;
		form
]

{ #category : #initialization }
MiCoMarkManager >> initialize [
	super initialize.
	menuInteraction := RSMenuActivable new
		menuDo: [ :menu :aShape | self createMenuOn: menu for: aShape ];
		yourself.
]

{ #category : #hooks }
MiCoMarkManager >> onShape: aShape [
	aShape addInteraction: menuInteraction.
]

{ #category : #public }
MiCoMarkManager >> setTag: aMicoTag onAttribute: aMicoTaggedObject [
	| color |
	aMicoTaggedObject tag: aMicoTag.
	color := self tagColorFrom: aMicoTag.
	(self coUsageMap canvas deepShapesFromModel: aMicoTaggedObject) 
		do: [ :shape | shape color: color ].
	self coUsageMap canvas signalUpdate.
]

{ #category : #'building - menus' }
MiCoMarkManager >> subMenuTagsFor: aMiCoAttribute subMenu: menu [
	self coUsageMap legendTag tags do: [ :aMiCoTag |
		(menu 
			add: aMiCoTag label
				target: self
				selector: #setTag:onAttribute:
				argumentList: { aMiCoTag. aMiCoAttribute })
			icon: (self iconFormFor: aMiCoTag) ].
	aMiCoAttribute tag ifNotNil: [ 
		menu addLine.
		(menu 
			add: 'Remove tag'
				target: self
				selector: #setTag:onAttribute:
				argumentList: { nil. aMiCoAttribute })
			icon: (self iconNamed: 'remove')
		 ].
	^ menu
]

{ #category : #accessing }
MiCoMarkManager >> tagColorFrom: aMicoTag [
	aMicoTag ifNil: [ ^ Color white ].
	^ aMicoTag color
]
