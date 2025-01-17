Class {
	#name : 'MaIndicator',
	#superclass : 'BorderedMorph',
	#instVars : [
		'dot'
	],
	#category : 'Marmelal-Spec',
	#package : 'Marmelal',
	#tag : 'Spec'
}

{ #category : 'accessing' }
MaIndicator >> color: aColor [
	dot color: aColor
]

{ #category : 'initialization' }
MaIndicator >> initialize [
 	super initialize.
	self bounds: (0@0 corner: 25@25).
	dot := CircleMorph newBounds: (4@4 corner: 22@22).
	self addMorph: dot.
	self color: Color black.
	dot color: Color green
]
