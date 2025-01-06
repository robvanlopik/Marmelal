Class {
	#name : 'MaHouse',
	#superclass : 'Object',
	#instVars : [
		'floors',
		'rooms',
		'ssrs',
		'currents',
		'aircos',
		'exterior'
	],
	#category : 'Marmelal-Core',
	#package : 'Marmelal',
	#tag : 'Core'
}

{ #category : 'accessing' }
MaHouse >> aircos [

	^ aircos
]

{ #category : 'accessing' }
MaHouse >> aircos: anObject [

	aircos := anObject
]

{ #category : 'accessing' }
MaHouse >> currents [ 
	^currents
]

{ #category : 'accessing' }
MaHouse >> currents: anObject [

	currents := anObject
]

{ #category : 'examples' }
MaHouse >> example1 [
	"make a house with fictive data"
	
	(self floors at: 1) temp: 17; setpoints: 16; ssrState: 'A'.
	(self floors at: 2) temp: 18; setpoints: 16; ssrState: 'O'.
	(self floors at: 3) temp: 17; setpoints: 17; ssrState: 'U'.
	(self floors at: 4) temp: 20; setpoints: 21; ssrState: 'A'.
	(self floors at: 5) temp: 17; setpoints: 16; ssrState: 'A'.
]

{ #category : 'accessing' }
MaHouse >> exterior [

	^ exterior
]

{ #category : 'accessing' }
MaHouse >> exterior: anObject [

	exterior := anObject
]

{ #category : 'accessing' }
MaHouse >> fakeValues [
	"assugn some fake values for testing (UI en Web)"
	(floors at: 1) temp: 20.111.
	(floors at: 2) temp: 19.0.
	(floors at: 3) temp: -1.0.
	(floors at: 4) temp: -2.0.
	"rest remains nil"
	self initTimestamps.
	
	
]

{ #category : 'as yet unclassified' }
MaHouse >> floorENamed: aString [
"return the floor with english name aString"
	^floors detect: [ :f | f ename = aString ]
]

{ #category : 'as yet unclassified' }
MaHouse >> floorNamed: aString [
	^ floors detect: [  :f |f name = aString ]
]

{ #category : 'accessing' }
MaHouse >> floors [
	^ floors
]

{ #category : 'accessing' }
MaHouse >> floors: anObject [
	floors := anObject
]

{ #category : 'initialization' }
MaHouse >> initTimestamps [
	"set initial timestamps to now (startup of app)"
	self floors do: [  :floor | floor tempTimestamp: DateAndTime now].
	self ssrs do: [  :ssr | ssr tempTimestamp: DateAndTime now]
]

{ #category : 'initialization' }
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
	(floors at: 6) ename: 'office'.
	(floors at: 7) ename: 'bath'.
	
	#(1 2 3 4 5 ) do: [ :i | (floors at: 1) readSetpointFileAnalog ].
	#(6 7) do: [ :i | (floors at: 1) readSetpointFileBinary ].
	
	ssrs := Array new: 8.
	1 to: 7 do: [  :i | ssrs at: i put: MaSSR new  ].
	
	currents := Array new: 3 withAll: 0.
]

{ #category : 'accessing' }
MaHouse >> rooms [

	^ rooms
]

{ #category : 'accessing' }
MaHouse >> rooms: anObject [

	rooms := anObject
]

{ #category : 'accessing' }
MaHouse >> ssrs [
	^ ssrs
]

{ #category : 'accessing' }
MaHouse >> ssrs: anObject [
	ssrs := anObject
]

{ #category : 'helper' }
MaHouse >> timeIndexNow [
	 "return the actual time as a timeindex (48 intervals
	 in Arduino it runs 0..47 but here we will use the intervl 1..48 
	because of Smalltalks array indexing"

	^(Time now asSeconds // 1800) + 1
]
