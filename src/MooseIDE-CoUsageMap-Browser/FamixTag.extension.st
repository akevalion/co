Extension { #name : #FamixTag }

{ #category : #'*MooseIDE-CoUsageMap-Browser' }
FamixTag >> addReference: aMiCoTaggedObject [

	| tagAssociation |
	self tagEntity: aMiCoTaggedObject rawObject.
	tagAssociation := (aMiCoTaggedObject rawObject allTagAssociations 
		                   select: [ :asso | asso tag = self ]) first.
	aMiCoTaggedObject application ifNotNil: [ :app | 
		app consumeItem: tagAssociation ]
]

{ #category : #'*MooseIDE-CoUsageMap-Browser' }
FamixTag >> asMiCoTag [
	"self flag: 'TODO'.
	^ MiCoTag new
		name: self name;
		color: self color;
		description: self description;
		yourself
		"
	^ self
]

{ #category : #'*MooseIDE-CoUsageMap-Browser' }
FamixTag >> removeReference: aMiCoTaggedObject [

	| tagAssociation |
	tagAssociation :=  aMiCoTaggedObject rawObject allTagAssociations detect: [ :assoc | assoc tag = self ].
	
	aMiCoTaggedObject rawObject removeTag: self.
	aMiCoTaggedObject application ifNotNil: [ :app | 
		app removeItem: tagAssociation  ]
	
]
