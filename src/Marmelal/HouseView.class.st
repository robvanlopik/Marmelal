Class {
	#name : 'HouseView',
	#superclass : 'BorderedMorph',
	#instVars : [
		'house',
		'floormorphs'
	],
	#category : 'Marmelal-Spec',
	#package : 'Marmelal',
	#tag : 'Spec'
}

{ #category : 'initialization' }
HouseView >> initialize [ 

	super initialize.
	self bounds: (100@100 extent: 420@240 ).
	self color: Color paleYellow 
]
