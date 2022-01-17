"
Baseline of the prototype
"
Class {
	#name : #BaselineOfCoUsageMap,
	#superclass : #BaselineOf,
	#category : #BaselineOfCoUsageMap
}

{ #category : #baselines }
BaselineOfCoUsageMap >> baseline: spec [
	<baseline>
	"https://github.com/akevalion/CoUsageProto"
	spec for: #'common' do: [ 
		spec
			package: #'MooseIDE-CoUsageMap-Model';
			package: #'MooseIDE-CoUsageMap';
			package: #'MooseIDE-CoUsageMap-Examples';
			package: #'MooseIDE-CoUsageMap-Tests'
			
		 ].
]
