"
A MiCoAttributeTest is a test class for testing the behavior of MiCoAttribute
"
Class {
	#name : #MiCoAttributeTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-CoUsageMap-Tests'
}

{ #category : #tests }
MiCoAttributeTest >> testPopupMessage [
	| attribute method |
	attribute := MiCoAttribute new.
	attribute name: #var1.
	attribute method: (method := MiCoMethod new selector: #method1) counter: 3.
	attribute method: (MiCoMethod new selector: #method2) counter: 6.
	attribute method: (MiCoMethod new selector: #method3) counter: 1.
	attribute method: (MiCoMethod new selector: #method8) counter: 2.
	
	self assert: (attribute asStringForMethod: method) equals: ('Accesses for var1:

3 access from this method(method1)
9 access from 3 local methods' copyReplaceAll: String cr with: String crlf).

	attribute := MiCoAttribute new.
	attribute name: #var2.
	attribute method: (method := MiCoMethod new selector: #method5) counter: 4.
	
	self assert: (attribute asStringForMethod: method) equals: ('Accesses for var2:

4 access from this method(method5)' copyReplaceAll: String cr with: String crlf).

	attribute := MiCoAttribute new.
	attribute name: #var2.
	attribute method: (method := MiCoMethod new selector: #method5) counter: 4.
	attribute method: (MiCoMethod new selector: #method6) counter: 9.
	
	self assert: (attribute asStringForMethod: method) equals: ('Accesses for var2:

4 access from this method(method5)
9 access from 1 local method' copyReplaceAll: String cr with: String crlf).
]
