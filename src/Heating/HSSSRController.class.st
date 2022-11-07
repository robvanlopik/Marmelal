Class {
	#name : #HSSSRController,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #Heating
}

{ #category : #connection }
HSSSRController >> connectOnPort: aPortString [
	port := SerialPort new openPort: aPortString.
]

{ #category : #accessing }
HSSSRController >> currents [
	"receive currents"
	port readByteArray.  "empty input"
	port nextPutAll: (ByteArray with: $I asInteger with: 10).
	100 milliSeconds wait.
	^(port readByteArray: 100) allButFirst
]

{ #category : #accessing }
HSSSRController >> port [
	^port
]

{ #category : #accessing }
HSSSRController >> status [
	"receive status string"
	port readByteArray.  "empty input"
	port nextPutAll: (ByteArray with: $S asInteger with: 10).
	10 milliSeconds wait.
	^port readByteArray: 100.
]

{ #category : #'as yet unclassified' }
HSSSRController >> switchOff: ssrNr [
	| message |
	message := ByteArray with: $U asInteger with: (ssrNr + 48) with: 10.
	port nextPutAll: message
]

{ #category : #'as yet unclassified' }
HSSSRController >> switchOn: ssrNr [
	| message |
	message := ByteArray with: $A asInteger with: (ssrNr + 48) with: 10.
	port nextPutAll: message
]
