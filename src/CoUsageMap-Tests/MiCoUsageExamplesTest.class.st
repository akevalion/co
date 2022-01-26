Class {
	#name : #MiCoUsageExamplesTest,
	#superclass : #TestCase,
	#category : #'CoUsageMap-Tests'
}

{ #category : #tests }
MiCoUsageExamplesTest >> testAllExamples [

	| tmp1 tmp2 |
	tmp1 := MiCoUsageMapExamples new.
	tmp2 := tmp1 class methods select: [ :arg1 | 
		        (arg1 selector beginsWith: 'example') and: [ 
			        [ 
			        tmp1 perform: arg1 selector.
			        false ]
				        on: Error
				        do: [ :arg2 | true ] ] ].
	self assert: tmp2 isEmpty description: 'should run without errors'
]
