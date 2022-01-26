Class {
	#name : #MiCoMarkManagerTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoMarkManagerTest >> test01ColorASingleMethod [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp1 godClass: MiCoTestClass.
	tmp1 legendTag conflictTag: 'conflic' tags: { 'base'. 'simple' }.
	tmp1 build.
	tmp2 := tmp1 attributeNamed: #var6.
	tmp3 := tmp1 tagNamed: 'base'.
	tmp5 := tmp1 markManager tagColorFrom: nil.
	tmp4 := tmp1 canvas deepShapesFromModel: tmp2.
	self
		assert: tmp4 size equals: 2;
		assert: (tmp4 allSatisfy: [ :arg1 | arg1 color = tmp5 ]).
	tmp1 markManager setTag: tmp3 onAttribute: tmp2.
	self assert: (tmp4 allSatisfy: [ :arg2 | arg2 color = tmp3 color ]).
	tmp1 markManager automaticColor.
	tmp6 := tmp1 methodNamed: #method4.
	tmp7 := tmp1 methodNamed: #method4.
	self
		assert: (tmp1 canvas shapeFromModel: tmp6) children second color
		equals: tmp3 color;
		assert: (tmp1 canvas shapeFromModel: tmp7) children second color
		equals: tmp3 color
]

{ #category : #tests }
MiCoMarkManagerTest >> test02OpenMenu [

	| tmp1 tmp2 tmp3 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp1 godClass: MiCoTestClass.
	tmp1 legendTag conflictTag: 'conflic' tags: { 'base'. 'simple' }.
	tmp1 build.
	tmp2 := tmp1 attributeNamed: #var2.
	tmp3 := tmp1 methodNamed: #method1.
	tmp2 createMenuOn: MenuMorph new markManager: tmp1 markManager.
	tmp3 createMenuOn: MenuMorph new markManager: tmp1 markManager.
	tmp1 markManager
		createGlobalMenuOn: MenuMorph new;
		createMenuOn: MenuMorph new for: tmp1 canvas
]

{ #category : #tests }
MiCoMarkManagerTest >> test03MarkingAttributes [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp1 legendTag
		conflictTag: 'need work'
		tags: { 'Frame'. 'Connection' }.
	tmp1 build.
	tmp4 := tmp1 tagNamed: 'Frame'.
	tmp3 := tmp1 attributeNamed: 'var2'.
	tmp1 markManager setTag: tmp4 onAttribute: tmp3.
	self assert:
		((tmp1 canvas deepShapesFromModel: tmp3) allSatisfy: [ :arg1 | 
			 arg1 color = tmp4 color ])
]

{ #category : #tests }
MiCoMarkManagerTest >> test04ClickLastTag [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp1 legendTag
		conflictTag: 'need work'
		tags: { 'Frame'. 'Connection' }.
	tmp1 build.
	self assert: tmp1 markManager lastTagSelected isNil.
	tmp3 := tmp1 attributeNamed: #var2.
	tmp4 := tmp1 methodNamed: #method1.
	tmp5 := tmp1 tagNamed: 'Frame'.
	tmp1 markManager setTag: tmp5 onAttribute: tmp3.
	self assert: tmp1 markManager lastTagSelected notNil.
	tmp1 markManager
		lastTagSelected: nil;
		setTag: tmp5 onAttribute: tmp4.
	self assert: tmp1 markManager lastTagSelected notNil
]

{ #category : #tests }
MiCoMarkManagerTest >> test05ClickLastTag [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp10 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp1 legendTag
		conflictTag: 'need work'
		tags: { 'Frame'. 'Connection' }.
	tmp1 build.
	tmp3 := tmp1 attributeNamed: #var1.
	tmp4 := tmp1 attributeNamed: #var2.
	tmp5 := tmp1 methodNamed: #method1.
	tmp6 := tmp1 tagNamed: 'Frame'.
	tmp8 := tmp1 markManager tagColorFrom: nil.
	tmp7 := tmp1 canvas deepShapesFromModel: tmp3.
	tmp1 markManager clickOn: (RSMouseClick new shape: tmp7 first).
	self
		assert: tmp3 tag isNil;
		assert: (tmp7 allSatisfy: [ :arg1 | arg1 color = tmp8 ]).
	tmp1 markManager
		lastTagSelected: tmp6;
		clickOn: (RSMouseClick new shape: tmp7 first).
	self
		assert: tmp3 tag isNil;
		assert: (tmp7 allSatisfy: [ :arg2 | arg2 color = tmp8 ]).
	tmp10 := RSMouseClick new.
	tmp10 shape: tmp7 first.
	tmp1 markManager clickOn: (tmp10 commandKeyPressed: true).
	self
		assert: tmp3 tag equals: tmp6;
		assert: (tmp7 allSatisfy: [ :arg3 | arg3 color = tmp6 color ])
]
