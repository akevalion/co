"
TODO
"
Class {
	#name : #MiCoMethodAttributeTester,
	#superclass : #Object,
	#category : #'CoUsageMap-Model'
}

{ #category : #public }
MiCoMethodAttributeTester >> numberOfUsesOf: aMiCoAttribute on: aMiCoMethod [
	"returns a number"
	^ self subclassResponsibility
]
