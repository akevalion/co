"
I have examples
"
Class {
	#name : #MiCoUsageExamples,
	#superclass : #Object,
	#category : #'MooseIDE-CoUsageMap-Examples'
}

{ #category : #examples }
MiCoUsageExamples >> example01 [
	<script: 'self new example01 open '>
	| v attributes methods |
	attributes := #().
	methods := #().
	v := MiCoUsageVisualization new.
	v attributes: attributes.
	v methods: methods.
	^ v
]
