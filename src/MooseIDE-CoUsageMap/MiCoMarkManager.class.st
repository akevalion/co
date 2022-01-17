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
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #accessing }
MiCoMarkManager >> coUsageMap [
	^ coUsageMap
]

{ #category : #accessing }
MiCoMarkManager >> coUsageMap: aMiCoCoUsageMapVisualization [
	coUsageMap := aMiCoCoUsageMapVisualization
]

{ #category : #'building - menus' }
MiCoMarkManager >> createMenu: aMenuMorph for: aMiCoAttribute [
	aMenuMorph
		addTitle: 'Var: <',aMiCoAttribute name,'>';
		add: 'Tags' 
			subMenu: (self subMenuTagsFor: aMiCoAttribute);
		add: 'Inspect'
			target: aMiCoAttribute
			selector: #inspect
			argument: #() 
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
		menuDo: [ :menu :box | self createMenu: menu for: box model ];
		yourself.
]

{ #category : #hooks }
MiCoMarkManager >> onShape: aShape [
	aShape addInteraction: menuInteraction.
]

{ #category : #public }
MiCoMarkManager >> setTag: aMicoTag onAttribute: aMicoAttribute [

	aMicoAttribute tag: aMicoTag.
	(self coUsageMap canvas deepShapesFromModel: aMicoAttribute) do: [ :shape |
		shape color: aMicoTag color ].
	self coUsageMap canvas signalUpdate.
]

{ #category : #'building - menus' }
MiCoMarkManager >> subMenuTagsFor: aMiCoAttribute [
	| menu |
	menu := MenuMorph new.
	self coUsageMap legendTagVisualization tags do: [ :aMiCoTag |
		(menu 
			add: aMiCoTag label
				target: self
				selector: #setTag:onAttribute:
				argumentList: { aMiCoTag. aMiCoAttribute })
			icon: (self iconFormFor: aMiCoTag) ].
	
	^ menu
]
