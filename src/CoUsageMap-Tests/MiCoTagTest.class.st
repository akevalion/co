Class {
	#name : #MiCoTagTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoTagTest >> testBasicAttribute [

	| tmp1 tmp2 tmp3 tmp5 |
	tmp5 := MiCoTag new.
	tmp5
		name: 'Frame';
		color: Color green;
		description: 'Basic'.
	tmp1 := tmp5 yourself.
	tmp2 := MiCoAttribute new name: 'var1'.
	tmp3 := MiCoAttribute new name: 'var2'.
	tmp2 tag: tmp1.
	tmp3 tag: tmp1.
	self
		assert: tmp2 tag equals: tmp1;
		assert: tmp1 references asArray equals: { 
				tmp2.
				tmp3 };
		assert: tmp1 description equals: 'Basic'
]

{ #category : #tests }
MiCoTagTest >> testBasicMethod [

	| tmp1 tmp2 tmp3 tmp5 |
	tmp5 := MiCoTag new.
	tmp5
		name: 'Frame';
		color: Color green;
		description: 'Simple'.
	tmp1 := tmp5 yourself.
	tmp2 := MiCoMethod new name: 'method1'.
	tmp3 := MiCoMethod new name: 'method2'.
	tmp2 tag: tmp1.
	tmp3 tag: tmp1.
	self
		assert: tmp1 numberOfReferences equals: 2;
		assert: tmp2 tag equals: tmp1
]

{ #category : #tests }
MiCoTagTest >> testSettingTags [

	| tmp1 tmp2 tmp3 tmp4 tmp6 tmp8 |
	tmp6 := MiCoTag new.
	tmp6
		name: 'Frame';
		color: Color green.
	tmp1 := tmp6 yourself.
	tmp8 := MiCoTag new.
	tmp8
		name: 'Connection';
		color: Color red.
	tmp2 := tmp8 yourself.
	tmp3 := MiCoAttribute new name: 'var1'.
	tmp4 := MiCoAttribute new name: 'var2'.
	tmp3 tag: tmp1.
	tmp4 tag: tmp1.
	self
		assert: tmp1 numberOfReferences equals: 2;
		assert: tmp3 tag equals: tmp1;
		assert: tmp2 numberOfReferences equals: 0.
	tmp3 tag: tmp2.
	self
		assert: tmp1 numberOfReferences equals: 1;
		assert: tmp2 numberOfReferences equals: 1.
	tmp4 tag: nil.
	self assert: tmp1 numberOfReferences equals: 0
]
