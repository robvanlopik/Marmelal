"
I communicate with ""doos1"", an Arduino that measures the currents in 3 phases and control 8 ssrs, through a simple 1-letter comms protocol

!! probably needd semaphore or access must be serialized
"
Class {
	#name : #MaSerialController,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : 'Marmelal-Comms'
}

{ #category : #connection }
MaSerialController >> connectOnPort: aPortString [
	port := SerialPort new openPort: aPortString.
]

{ #category : #accessing }
MaSerialController >> currents [
	"receive currents"
	port readByteArray.  "empty input"
	port nextPutAll: (ByteArray with: $I asInteger with: 10).
	50 milliSeconds wait.
	^(port readByteArray: 100) allButFirst
]

{ #category : #'instance creation' }
MaSerialController >> on: ssrNr for: mins [
	self switchOn: ssrNr.
	mins minutes wait.
	self switchOff: ssrNr
]

{ #category : #accessing }
MaSerialController >> port [
	^port
]

{ #category : #accessing }
MaSerialController >> status [
	"receive status string"
	port readByteArray.  "empty input"
	port nextPutAll: (ByteArray with: $S asInteger with: 10).
	50 milliSeconds wait.
	^(port readByteArray: 100).
]

{ #category : #controlling }
MaSerialController >> switchOff: ssrNr [
	| message |
	message := ByteArray with: $U asInteger with: (ssrNr + 48) with: 10.
	port nextPutAll: message
]

{ #category : #controlling }
MaSerialController >> switchOn: ssrNr [
	| message |
	message := ByteArray with: $A asInteger with: (ssrNr + 48) with: 10.
	port nextPutAll: message
]
