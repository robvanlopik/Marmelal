Class {
	#name : #MaHouse,
	#superclass : #Object,
	#instVars : [
		'floors',
		'rooms',
		'ssrs',
		'currents',
		'aircos',
		'exterior'
	],
	#category : #'Marmelal-Core'
}

{ #category : #accessing }
MaHouse >> currents [ 
	^currents
]

{ #category : #examples }
MaHouse >> example1 [
	"make a house with fictive data"
	
	(self floors at: 1) temp: 17; setpoint: 16; ssrState: 'A'.
	(self floors at: 2) temp: 18; setpoint: 16; ssrState: 'O'.
	(self floors at: 3) temp: 17; setpoint: 17; ssrState: 'U'.
	(self floors at: 4) temp: 20; setpoint: 21; ssrState: 'A'.
	(self floors at: 5) temp: 17; setpoint: 16; ssrState: 'A'.
]

{ #category : #'as yet unclassified' }
MaHouse >> floorENamed: aString [
"return the floor with english name aString"
	^floors detect: [ :f | f ename = aString ]
]

{ #category : #'as yet unclassified' }
MaHouse >> floorNamed: aString [
	^ floors detect: [  :f |f name = aString ]
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
MaHouse >> initTimestamps [
	"set initial timestamps to now (startup of app)"
	self floors do: [  :floor | floor tempTimestamp: DateAndTime now]
]

{ #category : #initialization }
MaHouse >> initialize [ 
	super initialize.
	floors := Array new: 7.
	floors at: 1 put: (MaFloor new name: 'keuken').
	floors at: 2 put: (MaFloor new name: 'zitkamer').
	floors at: 3 put: (MaFloor new name: 'eetkamer').
	floors at: 4 put: (MaFloor new name: 'plateau').
	floors at: 5 put: (MaFloor new name: 'slaapkamer').
	floors at: 6 put: (MaFloor new name: 'kantoor').
	floors at: 7 put: (MaFloor new name: 'badkamer').
	"english names used by MQTT"
	(floors at: 1) ename: 'kitchen'.
	(floors at: 2) ename: 'living'.
	(floors at: 3) ename: 'dining'.
	(floors at: 4) ename: 'plateau'.
	(floors at: 5) ename: 'sleeping'.
	(floors at: 6) ename: 'bath'.
	(floors at: 7) ename: 'office'.
	"next not necessary? Except boiler?"
	ssrs := Array new: 3.
	ssrs at: 1 put: (MaSSR new name: 'kantoor').
	ssrs at: 2 put: (MaSSR new name: 'badkamer').
	ssrs at: 3 put: (MaSSR new name: 'boiler').
	
	currents := Array new: 3 withAll: 0.
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
