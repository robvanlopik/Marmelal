Class {
	#name : 'MaWebserver',
	#superclass : 'Object',
	#instVars : [
		'teapot',
		'house'
	],
	#category : 'Marmelal-Comms',
	#package : 'Marmelal',
	#tag : 'Comms'
}

{ #category : 'instance creation' }
MaWebserver class >> newOn: aHouse [
	^self new on: aHouse
]

{ #category : 'instance creation' }
MaWebserver >> on: aHouse [
	house := aHouse
]

{ #category : 'accessing' }
MaWebserver >> start [
	teapot ifNil: [ teapot := Teapot on 
		GET: '/' -> 'I am the viewer'; 
		GET: '/test' -> [  :r | self test]; start ]
]

{ #category : 'accessing' }
MaWebserver >> teapotIcon [ 
	^teapot
]

{ #category : 'accessing' }
MaWebserver >> test [
	^'test'
]
