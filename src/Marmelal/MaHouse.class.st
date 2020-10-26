Class {
	#name : #MaHouse,
	#superclass : #Object,
	#instVars : [
		'floors',
		'ssrs'
	],
	#category : #Marmelal
}

{ #category : #examples }
MaHouse >> example1 [
	"make a house with fictive data"
	
	(self floors at: 1) temp: 17; setpoint: 16; ssrState: 'A'.
	(self floors at: 2) temp: 18; setpoint: 16; ssrState: 'O'.
	(self floors at: 3) temp: 17; setpoint: 17; ssrState: 'U'.
	(self floors at: 4) temp: 20; setpoint: 21; ssrState: 'A'.
	(self floors at: 5) temp: 17; setpoint: 16; ssrState: 'A'.
]

{ #category : #accessing }
MaHouse >> floors [
	^ floors
]

{ #category : #accessing }
MaHouse >> floors: anObject [
	floors := anObject
]

{ #category : #initialization }
MaHouse >> initialize [ 
	super initialize.
	floors := Array new: 5.
	floors at: 1 put: (MaFloor new name: 'keuken').
	floors at: 2 put: (MaFloor new name: 'zitkamer').
	floors at: 3 put: (MaFloor new name: 'eetkamer').
	floors at: 4 put: (MaFloor new name: 'plateau').
	floors at: 5 put: (MaFloor new name: 'slaapkamer').
	
	ssrs := Array new: 3.
	ssrs at: 1 put: (MaSSR new name: 'kantoor').
	ssrs at: 2 put: (MaSSR new name: 'badkamer').
	ssrs at: 3 put: (MaSSR new name: 'boiler').
]

{ #category : #'as yet unclassified' }
MaHouse >> show1 [
	| view |
	
	view := MultiColumnListPresenter new.
	view items: self floors;
		displayBlock: [ :each | { each name . each temp asString . each setpoint asString . each ssrState} ].
	view openWithSpec
	
]

{ #category : #accessing }
MaHouse >> ssrs [
	^ ssrs
]

{ #category : #accessing }
MaHouse >> ssrs: anObject [
	ssrs := anObject
]

{ #category : #helper }
MaHouse >> timeIndexNow [
	 "return the actual time as a timeindex (48 intervals
	 in Arduino it runs 0..47 but here we will use the intervl 1..48 
	because of Smalltalks array indexing"

	^(Time now asSeconds // 1800) + 1
]
