"
Originally meant to be used with Spec, but if you dont use #start it also works as a webserver and full control application.

Its main task is to syart things up and ""host"" some pocesses doing the actual work

After #new it needs some data:
- the adrress of the MQTT broker: self mqttBroker: '192.168.1.23'
- the port of the serial/usb communicaton to 'doos1 ': self communicateOnPort: port baudRate: aNumber

then you can start things:
self startMQTTListener
self startSerial
self startHeating

eventually you coud start the GUI with
self startGUI
"
Class {
	#name : 'MaHouseApp',
	#superclass : 'SpApplication',
	#instVars : [
		'scheduler',
		'house',
		'serialController',
		'serialPort',
		'baudRate',
		'housePresenter',
		'mqttListener',
		'mqttBroker',
		'webserver'
	],
	#category : 'Marmelal-Spec',
	#package : 'Marmelal',
	#tag : 'Spec'
}

{ #category : 'action' }
MaHouseApp >> act [
	"write the calculated settings to the SSRs
	delay each time for 10 seconds to avoid large power changes"
	1 to: 5 do: [ :i |
		(house floors at: i) calculateSSRAnalog = 0 ifTrue: [ serialPort switchOff: ( i - 1)] 
																ifFalse: [ serialPort switchOn: ( i - 1)].
																10 seconds wait ].
	6 to: 7 do: [ :i |
		(house floors at: i) calculateSSRBinary = 0 ifTrue: [ serialPort switchOff: ( i - 1)] 
																ifFalse: [ serialPort switchOn: ( i - 1)].
																10 seconds wait].
]

{ #category : 'accessing' }
MaHouseApp >> baudRate [

	^ baudRate
]

{ #category : 'accessing' }
MaHouseApp >> baudRate: anObject [

	baudRate := anObject
]

{ #category : 'as yet unclassified' }
MaHouseApp >> communicateOnPort: aPort baudRate: aNumber [

	serialPort := aPort.
	baudRate := aNumber
]

{ #category : 'accessing' }
MaHouseApp >> house [ 
	^house
]

{ #category : 'accessing' }
MaHouseApp >> house: anObject [

	house := anObject
]

{ #category : 'accessing' }
MaHouseApp >> housePresenter [

	^ housePresenter
]

{ #category : 'accessing' }
MaHouseApp >> housePresenter: anObject [

	housePresenter := anObject
]

{ #category : 'initialization' }
MaHouseApp >> initialize [ 
	super initialize.
	
	scheduler := TaskScheduler new.
	scheduler start.
	
	house := MaHouse new..
	10 seconds wait.
	" self startSerial." 

]

{ #category : 'accessing' }
MaHouseApp >> mqttBroker [

	^ mqttBroker
]

{ #category : 'accessing' }
MaHouseApp >> mqttBroker: anObject [

	mqttBroker := anObject
]

{ #category : 'accessing' }
MaHouseApp >> mqttListener [

	^ mqttListener
]

{ #category : 'accessing' }
MaHouseApp >> mqttListener: anObject [

	mqttListener := anObject
]

{ #category : 'as yet unclassified' }
MaHouseApp >> processMessage: anMQTTMessage [
	"set the  tempeature of the floor in the topic"
	| floor temp |
	
	floor := anMQTTMessage topic copyReplaceAll: 'floors/' with: '' .
	temp := anMQTTMessage message.
	(house floorENamed: floor) temp: temp asString asNumber.
	(house floorENamed: floor) tempTimestamp: DateAndTime now
]

{ #category : 'as yet unclassified' }
MaHouseApp >> readSerial [
	"read currents and status and write to corresponding slots in house
	check status for length 10 (Sxxxxxxxxlf)
	and currentstring for end lf"
	| statusString currentsString |
	
	statusString := serialController status asString.
	((statusString size = 10) and: [ statusString last = Character lf ]) ifTrue: [  
		1 to: 8 do: 
		[ :i | (house ssrs at: i) state: (statusString at: (i + 1)); ssrTimestamp: (DateAndTime now) ]].
	
	currentsString := serialController currents asString.
	((currentsString last = Character lf) and: [currentsString  ])
	ifTrue: [ 
	(currentsString substrings: ',') withIndexDo: [ :s :i | house currents at: i put: (s asNumber) ]]
]

{ #category : 'accessing' }
MaHouseApp >> scheduler [

	^ scheduler
]

{ #category : 'accessing' }
MaHouseApp >> scheduler: anObject [

	scheduler := anObject
]

{ #category : 'accessing' }
MaHouseApp >> serialController [

	^ serialController
]

{ #category : 'accessing' }
MaHouseApp >> serialController: anObject [

	serialController := anObject
]

{ #category : 'accessing' }
MaHouseApp >> serialPort [

	^ serialPort
]

{ #category : 'accessing' }
MaHouseApp >> serialPort: anObject [

	serialPort := anObject
]

{ #category : 'running' }
MaHouseApp >> start [ 
	(self new: MaHousePresenter) open
]

{ #category : 'as yet unclassified' }
MaHouseApp >> startCycle [
	"start the actual cycles"
	scheduler do: 
		[ self act. 1 seconds wait. self readSerial ]
		every: 6 minutes
]

{ #category : 'as yet unclassified' }
MaHouseApp >> startMQTTListener [
	mqttListener := MQTTClient url: mqttBroker.
	mqttListener timeout: 70.
	mqttListener open.
	mqttListener subscribeToTopic: 'floors/+'.
	[mqttListener runWith: [ :message | self processMessage: message] ] forkNamed: 'MQTTLoop'
]

{ #category : 'startup' }
MaHouseApp >> startSerial [
	"start MaSerialController
	presupposes that port and baudrate have been set"
	serialController := MaSerialController new connectOnPort: serialPort
]

{ #category : 'as yet unclassified' }
MaHouseApp >> startWebserver [
	
	webserver := MaWebserver newOn: self house.
	webserver start
]

{ #category : 'accessing' }
MaHouseApp >> webserver [
	^webserver
]

{ #category : 'accessing' }
MaHouseApp >> webserver: anObject [

	webserver := anObject
]
