"
A MiCoTagTest is a test class for testing the behavior of MiCoTag
"
Class {
	#name : #MiCoTagTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-CoUsageMap-Tests'
}

{ #category : #tests }
MiCoTagTest >> testBasicAttribute [
	| tag attribute1 attribute2 |
	tag := MiCoTag new
		name: 'Frame';
		color: Color green;
		description: 'Basic';
		yourself.
		
	attribute1 := MiCoAttribute new name: 'var1'.
	attribute2 := MiCoAttribute new name: 'var2'.
	attribute1 tag: tag.
	attribute2 tag: tag.
	self assert: tag numberOfReferences equals: 2.
	self assert: attribute1 tag equals: tag.
	

]

{ #category : #tests }
MiCoTagTest >> testBasicMethod [
	| tag method1 method2 |
	tag := MiCoTag new
		name: 'Frame';
		color: Color green;
		description: 'Simple';
		yourself.
		
	method1 := MiCoMethod new name: 'method1'.
	method2 := MiCoMethod new name: 'method2'.
	method1 tag: tag.
	method2 tag: tag.
	self assert: tag numberOfReferences equals: 2.
	self assert: method1 tag equals: tag.
	

]

{ #category : #tests }
MiCoTagTest >> testSettingTags [
	| tag1 tag2 attribute1 attribute2 |
	tag1 := MiCoTag new
		name: 'Frame';
		color: Color green;
		yourself.
	tag2 := MiCoTag new
		name: 'Connection';
		color: Color red;
		yourself.
		
	attribute1 := MiCoAttribute new name: 'var1'.
	attribute2 := MiCoAttribute new name: 'var2'.
	attribute1 tag: tag1.
	attribute2 tag: tag1.
	self assert: tag1 numberOfReferences equals: 2.
	self assert: attribute1 tag equals: tag1.
	
	self assert: tag2 numberOfReferences equals: 0.
	attribute1 tag: tag2.
	self assert: tag1 numberOfReferences equals: 1.
	self assert: tag2 numberOfReferences equals: 1.
	
	attribute2 tag: nil.
	self assert: tag1 numberOfReferences equals: 0.
]
