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
			package: #'CoUsageMap-Model';
			package: #'CoUsageMap-Roassal3';
			package: #'MooseIDE-CoUsageMap-Browser';
			package: #'CoUsageMap-Examples';
			package: #'CoUsageMap-Tests'
			
		 ].
]
