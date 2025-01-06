"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMarmelal',
	#superclass : 'PackageManifest',
	#category : 'Marmelal-Manifest',
	#package : 'Marmelal',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMarmelal class >> ruleReCollectionAtCollectionSizeRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#Marmelal)) #'2025-01-03T18:02:02.26+00:00') )
]
