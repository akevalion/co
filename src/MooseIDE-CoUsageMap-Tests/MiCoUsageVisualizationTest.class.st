"
A MiCoUsageVisualizationTest is a test class for testing the behavior of MiCoUsageVisualization
"
Class {
	#name : #MiCoUsageVisualizationTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-CoUsageMap-Tests'
}

{ #category : #tests }
MiCoUsageVisualizationTest >> test01Basic [
	| v class |
	v := MiCoUsageMapBuilder new.
	v build.
	self assert: v canvas nodes size equals: 0.
	class := ZnUrl.
	v godClass: class.
	v build.
	self assert: v godClass equals: class.
	self assert: v miMethods size equals: class methods size.
	self assert: v miAttributes size equals: class instVarNames size.
	self assert: v canvas nodes size equals: class methods size.
	
	
	
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test02MethodsAttributes [
	| v class method attribute |
	v := MiCoUsageMapBuilder new.
	class := MiCoTestClass.
	v godClass: class.
	v build.
	self assert: v miMethods size equals: class methods size.
	self assert: v miAttributes size equals: class instVarNames size.
	method := v methodNamed: #method1.
	
	self assert: method class equals: MiCoMethod.
	self assert: method usedAttributes size equals: 2.
	self assert: method usedAttributes first class equals: MiCoAttribute.
	
	method := v methodNamed: #method2.
	self assert: method usedAttributes size equals: 0.
	
	method := v methodNamed: #method3.
	self assert: method usedAttributes size equals: 3.
	
	attribute := v attributeNamed: #var2.
	self assert: attribute usedInMethods size equals: 2.
	
	attribute := v attributeNamed: #var4.
	self assert: attribute usedInMethods size equals: 1.
	
	attribute := v attributeNamed: #var5.
	self assert: attribute usedInMethods size equals: 0.
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test03AttributeWidth [
	| v class method attribute shapes |
	v := MiCoUsageMapBuilder new.
	class := MiCoTestClass.
	v godClass: class.
	v build.
	
	attribute := v attributeNamed: #var1.
	method := v methodNamed: #method1.
	shapes := v canvas deepShapesFromModel: attribute.
	
	self assert: shapes size equals: attribute usedInMethods size.
	self assert: (attribute numberOfUsesOn: method) equals: 3.
	
	attribute := v attributeNamed: #var4.
	method := v methodNamed: #method3.
	self assert: (attribute numberOfUsesOn: method) equals: 1.
	
	
	
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test04Legend [
	| v class tv |
	v := MiCoUsageMapBuilder new.
	class := MiCoTestClass.
	v godClass: class.
	tv := MiCoTagVisualization new.
	v legendTag: tv.
	v build.
	"The title and the box description"
	self assert: tv shapes size equals: 2.
	
	tv conflictTag: (MiCoTag new
		label: 'need work';
		color: Color gray;
		yourself).
	tv addTag: (MiCoTag new
		label: 'Frame';
		color: Color lightBlue;
		yourself).
	tv addTag: (MiCoTag new
		label: 'Connection';
		color: Color green;
		yourself).
	v build.
	self assert: tv shapes size equals: 5.
	
	
	
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test05MarkingAttributes [
	| v class attribute tag |
	v := MiCoUsageMapBuilder new.
	class := MiCoTestClass.
	v godClass: class.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'  }.
	v build.
	
	tag := v tagNamed: 'Frame'.
	attribute := v attributeNamed: 'var2'.
	v markManager
		setTag: tag 
		onAttribute: attribute.
	self assert: ((v canvas deepShapesFromModel: attribute) 
		allSatisfy: [ :shape | 
			shape color = tag color ]).
]
