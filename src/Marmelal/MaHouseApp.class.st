Class {
	#name : #MaHouseApp,
	#superclass : #SpApplication,
	#instVars : [
		'scheduler',
		'house',
		'communication',
		'housePresenter',
		'mqttListener',
		'mqttBroker'
	],
	#category : #'Marmelal-Spec'
}

{ #category : #'as yet unclassified' }
MaHouseApp >> communicateOnPort: aPort baudRate: aNumber [

	communication := MaHomeComms onPort: aPort baudRate: aNumber
]

{ #category : #accessing }
MaHouseApp >> communication [

	^ communication
]

{ #category : #accessing }
MaHouseApp >> communication: anObject [

	communication := anObject
]

{ #category : #accessing }
MaHouseApp >> house [ 
	^house
]

{ #category : #accessing }
MaHouseApp >> house: anObject [

	house := anObject
]

{ #category : #accessing }
MaHouseApp >> housePresenter [

	^ housePresenter
]

{ #category : #accessing }
MaHouseApp >> housePresenter: anObject [

	housePresenter := anObject
]

{ #category : #initialization }
MaHouseApp >> initialize [ 
	super initialize.
	
"	scheduler := TaskScheduler new.
	scheduler start. "
	
	house := MaHouse new.

]

{ #category : #accessing }
MaHouseApp >> mqttBroker [

	^ mqttBroker
]

{ #category : #accessing }
MaHouseApp >> mqttBroker: anObject [

	mqttBroker := anObject
]

{ #category : #accessing }
MaHouseApp >> mqttListener [

	^ mqttListener
]

{ #category : #accessing }
MaHouseApp >> mqttListener: anObject [

	mqttListener := anObject
]

{ #category : #'as yet unclassified' }
MaHouseApp >> processMessage: anMQTTMessage [
	"set the  tempeature of the floor in the topic"
	| floor temp |
	
	floor := anMQTTMessage topic copyReplaceAll: 'floors/' with: '' .
	temp := anMQTTMessage message.
	(house floorENamed: floor) temp: temp asString asNumber.
	(house floorENamed: floor) tempTimestamp: DateAndTime now
]

{ #category : #'as yet unclassified' }
MaHouseApp >> readAllData [
	"read all data (currents, setpoint temps ssrs and store them in the correct places"
	| tempArray result |
	"actual temps"
	result := communication temperatures.
	result doWithIndex: [  :r :i | ( house floors at: i) temp: r  ].
	
]

{ #category : #accessing }
MaHouseApp >> scheduler [

	^ scheduler
]

{ #category : #accessing }
MaHouseApp >> scheduler: anObject [

	scheduler := anObject
]

{ #category : #running }
MaHouseApp >> start [ 
	(self new: MaHousePresenter) open
]

{ #category : #'as yet unclassified' }
MaHouseApp >> startMQTTListener [
	mqttListener := MQTTClient url: mqttBroker.
	mqttListener timeout: 70.
	mqttListener open.
	mqttListener subscribeToTopic: 'floors/+'.
	[mqttListener runWith: [ :message | self processMessage: message] ] forkNamed: 'MQTTLoop'
]
