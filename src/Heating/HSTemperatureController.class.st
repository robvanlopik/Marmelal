Class {
	#name : #HSTemperatureController,
	#superclass : #Object,
	#instVars : [
		'board',
		'lcdDevice'
	],
	#category : #Heating
}

{ #category : #accessing }
HSTemperatureController >> board [

	^ board
]

{ #category : #accessing }
HSTemperatureController >> board: anObject [

	board := anObject
]

{ #category : #connection }
HSTemperatureController >> connectOnPort: aPortName [
	
	board := PotsController new driver: (PotsFirmataDriver onPort: aPortName baudRate: 57600).
	self initLCD.
	self initADCs.
]

{ #category : #'as yet unclassified' }
HSTemperatureController >> initADCs [


]

{ #category : #'as yet unclassified' }
HSTemperatureController >> initLCD [

	lcdDevice := board installDevice: (PotsHD44780Device new pinIds: #(9 8 4 5 6 7))
]

{ #category : #accessing }
HSTemperatureController >> lcdDevice [

	^ lcdDevice
]

{ #category : #accessing }
HSTemperatureController >> lcdDevice: anObject [

	lcdDevice := anObject
]
