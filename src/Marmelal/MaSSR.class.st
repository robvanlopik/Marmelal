Class {
	#name : #MaSSR,
	#superclass : #Object,
	#instVars : [
		'state',
		'setpoint',
		'name'
	],
	#category : #Marmelal
}

{ #category : #accessing }
MaSSR >> name [
	^ name
]

{ #category : #accessing }
MaSSR >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MaSSR >> setpoint [
	^ setpoint
]

{ #category : #accessing }
MaSSR >> setpoint: anObject [
	setpoint := anObject
]

{ #category : #accessing }
MaSSR >> state [
	^ state
]

{ #category : #accessing }
MaSSR >> state: anObject [
	state := anObject
]
