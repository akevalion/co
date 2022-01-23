"
TODO
"
Class {
	#name : #MiCoUsageMapVisualization,
	#superclass : #MiAbstractVisualization,
	#category : #'MooseIDE-CoUsageMap-Roassal3'
}

{ #category : #hooks }
MiCoUsageMapVisualization >> attributeShapeFor: att method: met [
	^ RSBox new
		model: att;
		width: (att numberOfUsesOn: met) * 5;
		color: (self markManager tagColorFrom: att tag);
		border: (RSBorder new color: Color black);
		addInteraction: self markManager;
		when: RSMouseEnter send: #highlight: to: self;
		when: RSMouseLeave send: #unhighlight: to: self;
		addInteraction: (RSMorphicPopupInteraction new
			morphBuilder: [:model | 
				self createAttributeTextMorphFor: model method: met ];
			yourself);
		yourself.
]

{ #category : #default }
MiCoUsageMapVisualization >> defaultSortBlock [
	^ [ :met1 :met2 | 
		| size1 size2 |
		size1 := met1 usedAttributes size.
		size2 := met2 usedAttributes size.
		size1 = size2 
			ifTrue: [ met1 name < met2 name ]
			ifFalse: [ size1 > size2 ]
		 ].
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initialize [
	super initialize.
	self
		attributes: #();
		methods: #();
		layout: self defaultLayout;
		methodAttributeTester: self defaultTester;
		legendTag: self defaultLegendTagVisualization;
		markManager: self defaultMarkManager.
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initializeMethods [
	miMethods := methods collect: [ :met | 
		MiCoMethod new
			name: met selector;
			rawMethod: met;
			yourself ] as: OrderedCollection.
]

{ #category : #hooks }
MiCoUsageMapVisualization >> labelShapeFor: met [
	| label |
	label := RSLabel new
		text: met name;
		color: Color black;
		yourself.
	self resizeLabelIfNecessary: label.
	^ label.
]

{ #category : #accessing }
MiCoUsageMapVisualization >> legendTag [
	^ legendTagVisualization
]

{ #category : #accessing }
MiCoUsageMapVisualization >> legendTag: aMiCoTagVisualization [ 
	legendTagVisualization := aMiCoTagVisualization
]

{ #category : #hooks }
MiCoUsageMapVisualization >> methodBodyShapeFor: met [
	| attributesShapes |
	attributesShapes := met usedAttributes collect: [ :att | 
		self
			attributeShapeFor: att
			method: met ].
	RSFlowLayout on: attributesShapes.
	^ attributesShapes asGroup asShape
		padding: 10;
		color: (self markManager tagColorFrom: met tag);
		border: (RSBorder new color: Color black);
		yourself.
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methodNamed: aByteString [
	^ self miMethods detect: [ :met | met name = aByteString ]
]

{ #category : #hooks }
MiCoUsageMapVisualization >> methodShapeFor: met [
	| label body |
	label := self labelShapeFor: met.
	body := self methodBodyShapeFor: met.
	RSVerticalLineLayout new
		alignCenter;
		gapSize: 0;
		on: { label. body }.
	^ MiCoMethodShape new
		model: met;
		addAll: { label. body };
		adjustToChildren;
		addInteraction: self markManager;
		addInteraction: (RSMorphicPopupInteraction new
			morphBuilder: [:model | self createMethodTextMorphFor: model ];
			yourself);
		isFixed: true;
		yourself
]

{ #category : #opening }
MiCoUsageMapVisualization >> open [
	| window morph scrollPane |
	self build.
	morph := self canvas createMorph.
	morph extent: self canvas fixedShapes encompassingRectangle extent+50.
	window := SystemWindow new.
	scrollPane := ScrollPane new.
	scrollPane scroller addMorph: morph.
	window addMorph: scrollPane frame: (0@0 corner: 1@1).
	window extent: 1000@ 800.
	window openInWorld.
	window setLabel: (godClass
		ifNil: [ 'Empty' ]
		ifNotNil: ['God Class - ', godClass name ]).
	^ window
]

{ #category : #hooks }
MiCoUsageMapVisualization >> renderIn: aCanvas [
	self initializeValues.
	shapes := self miMethods collect: [ :met | self methodShapeFor: met ].
	aCanvas addAll: shapes.
	self layout on: shapes.
	self legendTag renderIn: aCanvas.
	aCanvas addInteraction: self markManager.
	
]

{ #category : #hooks }
MiCoUsageMapVisualization >> resizeLabelIfNecessary: label [
	| maxWidth text scale mid1 mid2 flag |
	text := label text.
	maxWidth := 200.
	maxWidth := self maxLabelWidth.
	label textWidth < maxWidth
		ifTrue: [ ^ self ].
	scale := maxWidth / label textWidth.
	mid1 := (text size / 2) asInteger -1.
	mid2 := mid1 + 1.
	flag := true.
	[ scale < 0.6 ] whileTrue: [ 
		| newText |
		newText := (text copyFrom: 1 to: mid1),'...',(text copyFrom: mid2 to: text size).
		label text: newText.
		scale := maxWidth / label textWidth.
		flag 
			ifTrue: [ mid1 := mid1 - 1 ]
			ifFalse: [ mid2 := mid2 + 1].
		flag := flag not.
	 ].
	label scaleBy: scale @ 1.
]

{ #category : #accessing }
MiCoUsageMapVisualization >> tagNamed: aString [ 
	^ self legendTag tagNamed: aString
]
