"
TODO
"
Class {
	#name : #MiCoPharoMethodAttributeTester,
	#superclass : #MiCoMethodAttributeTester,
	#category : #'MooseIDE-CoUsageMap'
}

{ #category : #public }
MiCoPharoMethodAttributeTester >> numberOfUsesOf: aMiCoAttribute on: aMiCoMethod [
	| name method result |
	name := aMiCoAttribute name.
	method := aMiCoMethod rawMethod.
	result := RBGenericNodeVisitor
		visit: method ast
		select: [ :node| node isInstanceVariable and: [ node name = name ] ].
		
	^ result size
]
