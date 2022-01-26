Class {
	#name : #MiCoTagVisualizationTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoTagVisualizationTest >> test01Legend [

	| tmp1 tmp2 tmp3 tmp5 tmp7 tmp9 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1 godClass: tmp2.
	tmp3 := MiCoTagVisualization new.
	tmp1
		legendTag: tmp3;
		build.
	self assert: tmp3 shapes size equals: 2.
	tmp5 := MiCoTag new.
	tmp5
		name: 'need work';
		color: Color gray.
	tmp3 conflictTag: tmp5 yourself.
	tmp7 := MiCoTag new.
	tmp7
		name: 'Frame';
		color: Color lightBlue.
	tmp3 addTag: tmp7 yourself.
	tmp9 := MiCoTag new.
	tmp9
		name: 'Connection';
		color: Color green.
	tmp3 addTag: tmp9 yourself.
	tmp1 build.
	self assert: tmp3 shapes size equals: 5
]

{ #category : #tests }
MiCoTagVisualizationTest >> test02Toggle [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := MiCoUsageMapBuilder new.
	tmp2 := MiCoTestClass.
	tmp1
		godClass: tmp2;
		build.
	tmp3 := (tmp1 canvas fixedShapes select: [ :arg1 | 
		         arg1 class = RSComposite ]) first.
	tmp4 := tmp3 children size.
	tmp1 legendTag toggleLegend: (RSMouseClick new shape: tmp3).
	self assert: tmp4 > tmp3 children size.
	tmp1 legendTag toggleLegend: (RSMouseClick new shape: tmp3).
	self assert: tmp3 children size equals: tmp4
]
