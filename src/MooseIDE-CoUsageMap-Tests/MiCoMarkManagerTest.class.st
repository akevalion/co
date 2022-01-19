"
A MiCoMarkManagerTest is a test class for testing the behavior of MiCoMarkManager
"
Class {
	#name : #MiCoMarkManagerTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-CoUsageMap-Tests'
}

{ #category : #tests }
MiCoMarkManagerTest >> test01ColorASingleMethod [
	| v attribute tag shapes defaultColor method4 method5 |
	v := MiCoUsageMapVisualization new.
	v godClass: MiCoTestClass.
	v legendTag
		conflictTag: 'conflic' tags: { 'base'. 'simple' }. 
	v build.
	
	attribute := v attributeNamed: #var6.
	tag := v tagNamed: 'base'.
	defaultColor := v markManager tagColorFrom: nil.
	
	shapes := v canvas deepShapesFromModel: attribute.
	self assert: shapes size equals: 2.
	self assert: (shapes allSatisfy: [ :shape | shape color = defaultColor ]).
	
	v markManager setTag: tag onAttribute: attribute.
	self assert: (shapes allSatisfy: [ :shape | shape color = tag color ]).
	
	v markManager automaticColor.
	method4 := v methodNamed: #method4.
	method5 := v methodNamed: #method4.
	self assert: (v canvas shapeFromModel: method4) children second color equals: tag color.
	self assert: (v canvas shapeFromModel: method5) children second color equals: tag color.
]
