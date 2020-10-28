Class {
	#name : #MaHouseApp,
	#superclass : #SpApplication,
	#instVars : [
		'scheduler',
		'house',
		'communication',
		'housePresenter'
	],
	#category : #Marmelal
}

{ #category : #'as yet unclassified' }
MaHouseApp >> communicateOnPort: aPort baudRate: aNumber [

	communication := MaHomeComms onPort: aPort baudRate: aNumber
]

{ #category : #accessing }
MaHouseApp >> house [ 
	^house
]

{ #category : #initialization }
MaHouseApp >> initialize [ 
	super initialize.
	
	scheduler := TaskScheduler new.
	scheduler start.
	
	house := MaHouse new.

]

{ #category : #'as yet unclassified' }
MaHouseApp >> readAllData [
	"read all data (currents, setpoint temps ssrs and store them in the correct places"
	| tempArray result |
	"actual temps"
	result := communication temperatures.
	result doWithIndex: [  :r :i | ( house floors at: i) temp: r  ].
	
]

{ #category : #running }
MaHouseApp >> start [ 
	(self new: MaHousePresenter) openWithSpec
]
