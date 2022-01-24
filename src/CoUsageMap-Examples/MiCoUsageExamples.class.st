"
I have examples
"
Class {
	#name : #MiCoUsageExamples,
	#superclass : #Object,
	#category : #'CoUsageMap-Examples'
}

{ #category : #examples }
MiCoUsageExamples >> example01Empty [
	<script: 'self new example01Empty open '>
	| v attributes methods |
	attributes := #().
	methods := #().
	v := MiCoUsageMapBuilder new.
	v attributes: attributes.
	v methods: methods.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example02RandomGodClass [
	<script: 'self new example02RandomGodClass open'>
	| v |
	v := MiCoUsageMapBuilder new.
	v godClass: self randomGodClass.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example03SystemWindow [
	<script: 'self new example03SystemWindow open'>
	| v |
	v := MiCoUsageMapBuilder new.
	v godClass: SystemWindow.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example04PNGReadWriter [
	<script: 'self new example04PNGReadWriter open'>
	| v |
	v := MiCoUsageMapBuilder new.
	v godClass: PNGReadWriter.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example05FileList [
	<script: 'self new example05FileList open'>
	| v |
	v := MiCoUsageMapBuilder new.
	v godClass: FileList.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	^ v
]

{ #category : #examples }
MiCoUsageExamples >> example06MCClassDefinition [
	<script: 'self new example06MCClassDefinition open'>
	| v |
	v := MiCoUsageMapBuilder new.
	v godClass: MCClassDefinition.
	v legendTag
		conflictTag: 'need work' tags: { 'Frame'. 'Connection'. 'Test'. 'Base' }.
	^ v
]

{ #category : #accessing }
MiCoUsageExamples >> randomGodClass [
	| allClasses godClasses |
	allClasses := RPackage organizer packages 
		flatCollect: [ :pkg | pkg definedClasses ].
	godClasses := allClasses select: [ :cls | 
		cls numberOfVariables > 8 
			and: [ cls methods size > 30
				and: [ cls linesOfCode > 300 ] ] ].
	
	^ godClasses atRandom
]
