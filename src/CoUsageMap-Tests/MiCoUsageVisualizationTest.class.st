Class {
	#name : #MiCoUsageVisualizationTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoUsageVisualizationTest >> test00Basic [

	| tmp1 tmp2 tmp3 |
	tmp1 := MiCoUsageMapBuilder new.
	self assert: tmp1 canvas nodes size equals: 0.
	tmp2 := ZnUrl.
	tmp1 godClass: tmp2.
	tmp3 := tmp1 open.
	tmp3 delete
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test01Basic [

	| tmp1 tmp2 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp1 build.
	self assert: tmp1 canvas nodes size equals: 0.
	tmp2 := ZnUrl.
	tmp1
		godClass: tmp2;
		build.
	self
		assert: tmp1 godClass equals: tmp2;
		assert: tmp1 miMethods size equals: tmp2 methods size;
		assert: tmp1 miAttributes size equals: tmp2 instVarNames size;
		assert: tmp1 canvas nodes size equals: tmp2 methods size
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test02MethodsAttributes [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1
		godClass: tmp2;
		build.
	self
		assert: tmp1 miMethods size equals: tmp2 methods size;
		assert: tmp1 miAttributes size equals: tmp2 instVarNames size.
	tmp3 := tmp1 methodNamed: #method1.
	self
		assert: tmp3 class equals: MiCoMethod;
		assert: tmp3 usedAttributes size equals: 2;
		assert: tmp3 usedAttributes first class equals: MiCoAttribute.
	tmp3 := tmp1 methodNamed: #method2.
	self assert: tmp3 usedAttributes size equals: 0.
	tmp3 := tmp1 methodNamed: #method3.
	self assert: tmp3 usedAttributes size equals: 3.
	tmp4 := tmp1 attributeNamed: #var2.
	self assert: tmp4 usedInMethods size equals: 2.
	tmp4 := tmp1 attributeNamed: #var4.
	self assert: tmp4 usedInMethods size equals: 1.
	tmp4 := tmp1 attributeNamed: #var5.
	self assert: tmp4 usedInMethods size equals: 0
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test03AttributeWidth [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1
		godClass: tmp2;
		build.
	tmp4 := tmp1 attributeNamed: #var1.
	tmp3 := tmp1 methodNamed: #method1.
	tmp5 := tmp1 canvas deepShapesFromModel: tmp4.
	self
		assert: tmp5 size equals: tmp4 usedInMethods size;
		assert: (tmp4 numberOfUsesOn: tmp3) equals: 3.
	tmp4 := tmp1 attributeNamed: #var4.
	tmp3 := tmp1 methodNamed: #method3.
	self assert: (tmp4 numberOfUsesOn: tmp3) equals: 1
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test04Highlight [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp7 tmp9 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp1 legendTag
		conflictTag: 'need work'
		tags: { 'Frame'. 'Connection' }.
	tmp1 build.
	tmp3 := tmp1 attributeNamed: #var2.
	tmp5 := tmp1 selectedBoxBorder.
	tmp4 := tmp1 canvas deepShapesFromModel: tmp3.
	tmp7 := RSMouseEnter new.
	tmp7 shape: tmp4 first.
	tmp1 highlight: tmp7 yourself.
	self assert: (tmp4 allSatisfy: [ :arg1 | 
			 arg1 border color = tmp5 color and: [ 
				 arg1 border width = tmp5 width ] ]).
	tmp9 := RSMouseLeave new.
	tmp9 shape: tmp4 first.
	tmp1 unhighlight: tmp9 yourself.
	self deny: (tmp4 allSatisfy: [ :arg2 | 
			 arg2 border color = tmp5 color and: [ 
				 arg2 border width = tmp5 width ] ])
]

{ #category : #tests }
MiCoUsageVisualizationTest >> test05MethodAttributePopup [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp1 legendTag
		conflictTag: 'need work'
		tags: { 'Frame'. 'Connection' }.
	tmp1 build.
	tmp3 := tmp1 attributeNamed: #var2.
	tmp4 := tmp1 methodNamed: #method1.
	tmp1
		createAttributeTextMorphFor: tmp3 method: tmp4;
		createMethodTextMorphFor: tmp4
]
