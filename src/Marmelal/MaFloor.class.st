Class {
	#name : 'MaFloor',
	#superclass : 'Object',
	#instVars : [
		'temp',
		'setpoint',
		'ssrState',
		'power',
		'name',
		'ename',
		'tempTimestamp'
	],
	#category : 'Marmelal-Core',
	#package : 'Marmelal',
	#tag : 'Core'
}

{ #category : 'accessing' }
MaFloor >> ename [
	^ename
]

{ #category : 'accessing' }
MaFloor >> ename: aString [
	ename := aString
]

{ #category : 'initialization' }
MaFloor >> initialize [ 
	
	tempTimestamp := DateAndTime now
]

{ #category : 'accessing' }
MaFloor >> name [
	^ name
]

{ #category : 'accessing' }
MaFloor >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
MaFloor >> power [
	^ power
]

{ #category : 'accessing' }
MaFloor >> power: anObject [
	power := anObject
]

{ #category : 'accessing' }
MaFloor >> setpoint [
	^ setpoint
]

{ #category : 'accessing' }
MaFloor >> setpoint: anObject [
	setpoint := anObject
]

{ #category : 'accessing' }
MaFloor >> ssrState [
	^ ssrState
]

{ #category : 'accessing' }
MaFloor >> ssrState: anObject [
	ssrState := anObject
]

{ #category : 'as yet unclassified' }
MaFloor >> ssrStateAsColor [
	(ssrState = #A) ifTrue: [ ^Color red ].
	(ssrState = #U) ifTrue: [  ^Color green ].
	(ssrState = #O) ifTrue: [  ^Color orange ].
	^Color gray .
]

{ #category : 'accessing' }
MaFloor >> temp [
	^ temp
]

{ #category : 'accessing' }
MaFloor >> temp: anObject [
	temp := anObject
]

{ #category : 'accessing' }
MaFloor >> tempAsString [
	"return the temperaaure as string with one decimal placeAtEnd 
	can also be 'not connected (- ), 'kortsluiting' of 'geen meting'
	(based on timestamp"

	temp isNil ifTrue: [ ^'?' ].
	temp = -1 ifTrue: [ ^'open' ].
	temp = -2 ifTrue: [ ^'kortsluiting ' ].
	DateAndTime now - tempTimestamp > 60 minutes ifTrue: [ ^'geen updates' ].
	^ temp printShowingDecimalPlaces: 1
]

{ #category : 'accessing' }
MaFloor >> tempTimestamp [

	^ tempTimestamp
]

{ #category : 'accessing' }
MaFloor >> tempTimestamp: anObject [

	tempTimestamp := anObject
]
