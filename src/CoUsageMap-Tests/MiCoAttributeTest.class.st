Class {
	#name : #MiCoAttributeTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoAttributeTest >> test01Method [

	| tmp1 |
	tmp1 := MiCoMethod new.
	tmp1
		name: #method1;
		usedAttributes: #(  ).
	self assert: tmp1 asString equals: #method1
]

{ #category : #tests }
MiCoAttributeTest >> test02Attribute [

	| tmp1 |
	tmp1 := MiCoAttribute new.
	tmp1
		name: #var1;
		usedInMethods: #(  ).
	self assert: tmp1 asString equals: #var1
]

{ #category : #tests }
MiCoAttributeTest >> test03PopupMessage [

	| tmp1 tmp2 |
	tmp1 := MiCoAttribute new.
	tmp1
		name: #var1;
		method: (tmp2 := MiCoMethod new name: #method1) counter: 3;
		method: (MiCoMethod new name: #method2) counter: 6;
		method: (MiCoMethod new name: #method3) counter: 1;
		method: (MiCoMethod new name: #method8) counter: 2.
	self
		assert: (tmp1 asStringForMethod: tmp2)
		equals: ('Accesses for var1:

3 access from this method(method1)
9 access from 3 local methods'
				 copyReplaceAll: String cr
				 with: String crlf).
	tmp1 := MiCoAttribute new.
	tmp1
		name: #var2;
		method: (tmp2 := MiCoMethod new name: #method5) counter: 4.
	self
		assert: (tmp1 asStringForMethod: tmp2)
		equals: ('Accesses for var2:

4 access from this method(method5)'
				 copyReplaceAll: String cr
				 with: String crlf).
	tmp1 := MiCoAttribute new.
	tmp1
		name: #var2;
		method: (tmp2 := MiCoMethod new name: #method5) counter: 4;
		method: (MiCoMethod new name: #method6) counter: 9.
	self
		assert: (tmp1 asStringForMethod: tmp2)
		equals: ('Accesses for var2:

4 access from this method(method5)
9 access from 1 local method'
				 copyReplaceAll: String cr
				 with: String crlf)
]
