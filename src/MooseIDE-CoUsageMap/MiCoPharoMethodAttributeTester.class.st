"
TODO
"
Class {
	#name : #MiCoPharoMethodAttributeTester,
	#superclass : #MiCoMethodAttributeTester,
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #testing }
MiCoPharoMethodAttributeTester >> doesMethod: aMiCoMethod use: aMiCoAttribute [
	| method attributeName |
	method := aMiCoMethod rawMethod.
	attributeName := aMiCoAttribute name.
	^ method accessesSlot: (method methodClass slotNamed: attributeName)
]

{ #category : #public }
MiCoPharoMethodAttributeTester >> visitNode: aNode [
	super visitNode: aNode.
	self visitBlock value: aNode
]
