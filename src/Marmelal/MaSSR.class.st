Class {
	#name : 'MaSSR',
	#superclass : 'Object',
	#instVars : [
		'state',
		'setpoint',
		'name',
		'ssrTimestamp'
	],
	#category : 'Marmelal-Core',
	#package : 'Marmelal',
	#tag : 'Core'
}

{ #category : 'initialization' }
MaSSR >> initialize [

	ssrTimestamp := DateAndTime now
	
]

{ #category : 'accessing' }
MaSSR >> name [
	^ name
]

{ #category : 'accessing' }
MaSSR >> name: anObject [
	name := anObject
]

{ #category : 'as yet unclassified' }
MaSSR >> setpointAsColor [
	(setpoint = 1) ifTrue: [ ^Color red ].
	(setpoint = 0) ifTrue: [  ^Color green ].
	
	^Color gray .
]

{ #category : 'accessing' }
MaSSR >> setpoints [
	^ setpoint
]

{ #category : 'accessing' }
MaSSR >> setpoints: anObject [
	setpoint := anObject
]

{ #category : 'accessing' }
MaSSR >> ssrTimestamp [

	^ ssrTimestamp
]

{ #category : 'accessing' }
MaSSR >> ssrTimestamp: anObject [

	ssrTimestamp := anObject
]

{ #category : 'accessing' }
MaSSR >> state [
	^ state
]

{ #category : 'accessing' }
MaSSR >> state: anObject [
	state := anObject
]

{ #category : 'as yet unclassified' }
MaSSR >> stateAsColor [
	(state = #A) ifTrue: [ ^Color red ].
	(state = #U) ifTrue: [  ^Color green ].
	(state = #O) ifTrue: [  ^Color orange ].
	^Color gray .
]
