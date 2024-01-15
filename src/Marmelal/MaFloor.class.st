Class {
	#name : #MaFloor,
	#superclass : #Object,
	#instVars : [
		'temp',
		'setpoint',
		'ssrState',
		'power',
		'name',
		'ename'
	],
	#category : #Marmelal
}

{ #category : #accessing }
MaFloor >> ename [
	^ename
]

{ #category : #accessing }
MaFloor >> ename: aString [
	ename := aString
]

{ #category : #accessing }
MaFloor >> name [
	^ name
]

{ #category : #accessing }
MaFloor >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MaFloor >> power [
	^ power
]

{ #category : #accessing }
MaFloor >> power: anObject [
	power := anObject
]

{ #category : #accessing }
MaFloor >> setpoint [
	^ setpoint
]

{ #category : #accessing }
MaFloor >> setpoint: anObject [
	setpoint := anObject
]

{ #category : #accessing }
MaFloor >> ssrState [
	^ ssrState
]

{ #category : #accessing }
MaFloor >> ssrState: anObject [
	ssrState := anObject
]

{ #category : #'as yet unclassified' }
MaFloor >> ssrStateAsColor [
	(ssrState = #A) ifTrue: [ ^Color red ].
	(ssrState = #U) ifTrue: [  ^Color green ].
	(ssrState = #O) ifTrue: [  ^Color orange ].
	^Color gray .
]

{ #category : #accessing }
MaFloor >> temp [
	^ temp
]

{ #category : #accessing }
MaFloor >> temp: anObject [
	temp := anObject
]
