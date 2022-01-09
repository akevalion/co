"
A MiCoUsageVisualizationTest is a test class for testing the behavior of MiCoUsageVisualization
"
Class {
	#name : #MiCoUsageVisualizationTest,
	#superclass : #TestCase,
	#category : #'MooseIDE-CoUsageMap-Tests'
}

{ #category : #tests }
MiCoUsageVisualizationTest >> test01Basic [
	| v |
	v := MiCoUsageVisualization new.
	v build.
	
	self assert: v canvas nodes size equals: 0.
	
]
