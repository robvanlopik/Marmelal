Class {
	#name : 'MaFloor',
	#superclass : 'Object',
	#instVars : [
		'temp',
		'setpoints',
		'setpointFile',
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

{ #category : 'as yet unclassified' }
MaFloor >> calculateSSRAnalog [
	"returns 0 or 1 depending on temp versus setpoint"
	| timeSlot |

	" first check for irregulat temp values"
	(temp < 0) ifTrue:	[ ^0 ]. " fault with temp measurement"
	(DateAndTime now - tempTimestamp) > 30 minutes ifTrue: [ ^0 ]. "no revent measurement"
	
	timeSlot := DateAndTime now secondsSinceMidnightLocalTime // 1800.
	temp < (setpoints at: (timeSlot + 1)) ifTrue: [ ^1 ].
	^0
]

{ #category : 'as yet unclassified' }
MaFloor >> calculateSSRBinary [
	"returns 0 or 1 depending on binary setpoint"
	| timeSlot |
	
	timeSlot := DateAndTime now secondsSinceMidnightLocalTime // 1800.
	^setpoints at: (timeSlot + 1)
]

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
	
	tempTimestamp := DateAndTime now.
	
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

{ #category : 'as yet unclassified' }
MaFloor >> readSetpointFileAnalog [
	| fileName file t |
	fileName := self name , '.txt'.
	file := FileLocator downloads / fileName.
	 " should check for existence!!)"
	file exists ifFalse: [ setpoints := Array new: 48  withAll: 16. ^self].
	t := (file readStream upToEnd) substrings.
	setpoints := t withIndexSelect: [ :a :i | ((i \\3) ~= 1) ]. "skip the hour indicator"
	setpoints := setpoints collect: [  :v | v asNumber ]
	"we should do some check, e.g setpoins size = 48"
]

{ #category : 'as yet unclassified' }
MaFloor >> readSetpointFileBinary [
	| fileName file t |
	fileName := self name , '.txt'.
	file := FileLocator downloads / fileName.
	 " should check for existence!!)"
	file exists ifFalse: [ setpoints := Array new: 48  withAll: 0. ^self].
	t := (file readStream upToEnd) substrings.
	setpoints := t withIndexSelect: [ :a :i | ((i \\3) ~= 1) ]. "skip the hour indicator"
	setpoints := setpoints collect: [  :v | v asNumber ]
	"we should do some check, e.g setpoins size = 48"
]

{ #category : 'accessing' }
MaFloor >> setpoints [
	^ setpoints
]

{ #category : 'accessing' }
MaFloor >> setpoints: anObject [
	setpoints := anObject
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
