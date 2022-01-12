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
		label: 'Frame';
		color: Color green;
		yourself.
		
	attribute1 := MiCoAttribute new name: 'var1'.
	attribute2 := MiCoAttribute new name: 'var1'.
	attribute1 tag: tag.
	attribute2 tag: tag.
	self assert: tag numberOfReferences equals: 2.
	self assert: attribute1 tag equals: tag.
	

]

{ #category : #tests }
MiCoTagTest >> testBasicMethod [
	| tag method1 method2 |
	tag := MiCoTag new
		label: 'Frame';
		color: Color green;
		yourself.
		
	method1 := MiCoMethod new selector: 'method1'.
	method2 := MiCoMethod new selector: 'method2'.
	method1 tag: tag.
	method2 tag: tag.
	self assert: tag numberOfReferences equals: 2.
	self assert: method1 tag equals: tag.
	

]
