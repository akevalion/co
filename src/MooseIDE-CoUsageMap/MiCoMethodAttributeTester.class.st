"
TODO
"
Class {
	#name : #MiCoMethodAttributeTester,
	#superclass : #Object,
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #public }
MiCoMethodAttributeTester >> numberOfUsesOf: aMiCoAttribute on: aMiCoMethod [
	"returns a number"
	^ self subclassResponsibility
]
