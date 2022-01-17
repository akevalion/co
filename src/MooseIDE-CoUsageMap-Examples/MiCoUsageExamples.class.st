"
I have examples
"
Class {
	#name : #MiCoUsageExamples,
	#superclass : #Object,
	#category : #'MooseIDE-CoUsageMap-Examples'
}

{ #category : #examples }
MiCoUsageExamples >> example01Empty [
	<script: 'self new example01Empty open '>
	| v attributes methods |
	attributes := #().
	methods := #().
	v := MiCoUsageMapVisualization new.
	v attributes: attributes.
	v methods: methods.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example02RandomGodClass [
	<script: 'self new example02RandomGodClass open'>
	| v |
	v := MiCoUsageMapVisualization new.
	v godClass: self randomGodClass.
	v legendTagVisualization
		conflicTag: 'need work' tags: { 'Frame'. 'Connection'  }.
	^ v
]

{ #category : #accessing }
MiCoUsageExamples >> randomGodClass [
	<script: 'self new randomGodClass inspect'>
	| allClasses godClasses |
	allClasses := RPackage organizer packages 
		flatCollect: [ :pkg | pkg definedClasses ].
	godClasses := allClasses select: [ :cls | 
		cls numberOfVariables > 8 
			and: [ cls methods size > 30
				and: [ cls linesOfCode > 300 ] ] ].
	
	^ godClasses atRandom
]
