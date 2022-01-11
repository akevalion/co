"
TODO
"
Class {
	#name : #MiCoUsageMapVisualization,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'methods',
		'attributes',
		'layout',
		'godClass',
		'miMethods',
		'miAttributes',
		'methodAttributeTester'
	],
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #accessing }
MiCoUsageMapVisualization >> attributeNamed: aByteString [
	^ self miAttributes detect: [ :met | met name = aByteString ]
]

{ #category : #hooks }
MiCoUsageMapVisualization >> attributeShapeFor: att [ 
	^ RSBox new
		model: att;
		width: att usedInMethods size * 5;
		noPaint;
		border: (RSBorder new color: Color black);
		when: RSMouseEnter send: #highlight: to: self;
		when: RSMouseLeave send: #unhighlight: to: self;
		popup;
		yourself
]

{ #category : #hooks }
MiCoUsageMapVisualization >> attributeShapeFor: att method: met [
	^ RSBox new
		model: att;
		width: (att numberOfUsesOn: met) * 5;
		noPaint;
		border: (RSBorder new color: Color black);
		when: RSMouseEnter send: #highlight: to: self;
		when: RSMouseLeave send: #unhighlight: to: self;
		popup;
		yourself
]

{ #category : #accessing }
MiCoUsageMapVisualization >> attributes [
	^ attributes
]

{ #category : #accessing }
MiCoUsageMapVisualization >> attributes: aCollection [
	attributes := aCollection
]

{ #category : #default }
MiCoUsageMapVisualization >> defaultLayout [
	^ RSFlowLayout new
		gapSize: 20;
		yourself
]

{ #category : #default }
MiCoUsageMapVisualization >> defaultTester [
	^ MiCoPharoMethodAttributeTester new
]

{ #category : #accessing }
MiCoUsageMapVisualization >> godClass [
	^ godClass
]

{ #category : #accessing }
MiCoUsageMapVisualization >> godClass: aClass [
	godClass := aClass.
	self attributes: aClass instVarNames.
	self methods: aClass methods.
]

{ #category : #highlighting }
MiCoUsageMapVisualization >> highlight: evt [
	| border attributeShapes | 
	attributeShapes := evt canvas deepShapesFromModel: evt shape model.
	evt canvas propertyAt: #highlighShapes put: attributeShapes.
	border := RSBorder new 
		color: Color orange;
		width: 3;
		yourself.
	attributeShapes do: [ :shape | shape border: border ].
	evt signalUpdate.
	
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initialize [
	super initialize.
	self
		attributes: #();
		methods: #();
		layout: self defaultLayout;
		methodAttributeTester: self defaultTester.
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initializeAttributes [
	miAttributes := attributes collect: [ :att |
		MiCoAttribute new
			name: att;
			yourself ] as: OrderedCollection
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initializeMethods [
	miMethods := methods collect: [ :met | 
		MiCoMethod new
			selector: met selector;
			rawMethod: met;
			yourself ] as: OrderedCollection.
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initializeReferences [
	self miMethods do: [ :met | 
		self miAttributes do: [ :att | | counter | 
			counter := self methodAttributeTester numberOfUsesOf: att on: met.
			counter > 0 ifTrue: [ 
				att method: met counter: counter.
				met addAttribute: att.
				 ].
			 ].
		 ].
]

{ #category : #initialization }
MiCoUsageMapVisualization >> initializeValues [
	self 
		initializeAttributes;
		initializeMethods;
		initializeReferences.
	
]

{ #category : #hooks }
MiCoUsageMapVisualization >> labelShapeFor: met [
	| label maxWidth |
	label := RSLabel new
		text: met selector;
		color: Color black;
		yourself.
	maxWidth := self maxLabelWidth.
	label textWidth > maxWidth
		ifTrue: [ label scaleBy: maxWidth / label textWidth @ 1 ].
	^ label.
]

{ #category : #accessing }
MiCoUsageMapVisualization >> layout [
	^ layout
]

{ #category : #accessing }
MiCoUsageMapVisualization >> layout: aRSLayout [
	layout := aRSLayout
]

{ #category : #accessing }
MiCoUsageMapVisualization >> maxLabelWidth [
	^ 200
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methodAttributeTester [
	^ methodAttributeTester
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methodAttributeTester: aMiCoMethodAttributeTester [
	methodAttributeTester := aMiCoMethodAttributeTester
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
		border: (RSBorder new color: Color black);
		yourself.
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methodNamed: aByteString [
	^ self miMethods detect: [ :met | met selector = aByteString ]
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
	^ ({ label. body } asGroup asShapeFor: met)
		popup;
		isFixed: true;
		yourself
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methods [
	^ methods
]

{ #category : #accessing }
MiCoUsageMapVisualization >> methods: aCollection [
	methods := aCollection
]

{ #category : #accessing }
MiCoUsageMapVisualization >> miAttributes [
	^ miAttributes
]

{ #category : #accessing }
MiCoUsageMapVisualization >> miMethods [
	^ miMethods
]

{ #category : #'instance creation' }
MiCoUsageMapVisualization >> open [
	| window morph scrollPane |
	self build.
	morph := self canvas createMorph.
	morph extent: self canvas fixedShapes encompassingRectangle extent+20.
	window := SystemWindow new.
	scrollPane := ScrollPane new.
	scrollPane scroller addMorph: morph.
	window addMorph: scrollPane frame: (0@0 corner: 1@1).
	window extent: 600@600.
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
	
]

{ #category : #highlighting }
MiCoUsageMapVisualization >> unhighlight: evt [
	| border attributeShapes key |
	key := #highlighShapes.
	attributeShapes := evt canvas propertyAt: key ifAbsent: [ #() ].
	border := RSBorder new color: Color black.
	attributeShapes do: [ :shape | shape border: border ].
	evt canvas removeKey: key.
	evt signalUpdate.
	
]
