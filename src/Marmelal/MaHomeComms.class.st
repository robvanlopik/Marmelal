Class {
	#name : #MaHomeComms,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #Marmelal
}

{ #category : #'as yet unclassified' }
MaHomeComms class >> onPort: portNumber baudRate: aNumber [
	^ self new
		connectOnPort: portNumber baudRate: aNumber;
		yourself
]

{ #category : #'as yet unclassified' }
MaHomeComms >> codeFromTemp: aTemp [
	"convert temperature to code
	we dont check for correct ranges!!"

	aTemp < 3 ifTrue: [ ^0 ].
	aTemp < 7 ifTrue: [ ^1 ].
	aTemp < 15 ifTrue: [ ^2 ].
	^(aTemp - 12)min: 15
	
]

{ #category : #connection }
MaHomeComms >> connectOnPort: portName baudRate: aNumber [
	"If the port cant't be open it stores nil, this way we can know if it is
	connected by asking if port is nil.
	On Linux portname is a string like /dev/..., on Windows just the COM-number; that is how 	#SerialPort works"
	
	self isConnected ifTrue: [^ self].
	port := SerialPort new baudRate: aNumber.
	port openPort: portName.
	

]

{ #category : #reading }
MaHomeComms >> currentSetpoints [
	"use the P command to retrieve the current setpoints, followed by the program Iprog (0-3)
	Left as strings, so the user can decide what to do with the pieces"

		| response |
	port nextPutAll: #(80 10) asByteArray .
	(Delay forMilliseconds: 400) wait.
	response := port readByteArray .
	^ response asString substrings .
	
]

{ #category : #reading }
MaHomeComms >> currents [
	"return the currents of the three fases with command C"

	| response c end|
	port nextPutAll: #(67 10) asByteArray .
	(Delay forMilliseconds: 400) wait.
	response := port readByteArray .
	"due to an error in doos2.ino the array contains some superfluous characters at the end"
	end := response lastIndexOf: 46.
	
	c := (response first: (end + 1 )) asString substrings: ',' .
	^c collect: [ :each | each asNumber asFloat ]
]

{ #category : #testing }
MaHomeComms >> isConnected [

	^port notNil
]

{ #category : #accessing }
MaHomeComms >> port [

	^port
	
]

{ #category : #helper }
MaHomeComms >> requestForFloor: aFloorNumber program: aProgramNumber [
	"helper to make requests return string encoding floor en prog"

	
	^(aProgramNumber + (4 * aFloorNumber) + 65) asCharacter asString .
]

{ #category : #'as yet unclassified' }
MaHomeComms >> sendSetpointsForFloor: aFloornumber program: aProgramNumber codes: anArray [
	"send data for setpoints plus checksum
	anArray is supposed to contain 48 values 0-15"

	| map floorProgramCode data sum sumhi sumlo |
	map := '0123456789ABCDEF'.
	"first construct the floorprogramcode"
	floorProgramCode  := (aProgramNumber + (4 * aFloornumber) + 65) asCharacter asString.
	data := anArray collect: [ :each | map at: (each + 1) ] as: String.
	sum := (anArray sum) \\ 256.
	sumhi := (map at: (sum // 16 + 1)) asString .
	sumlo := (map at: (sum \\ 16 + 1)) asString.
	port nextPutAll: ('W', floorProgramCode, data, sumhi, sumlo, Character linefeed asString).
]

{ #category : #'as yet unclassified' }
MaHomeComms >> sendSsrSetpointsForFloor: aFloorNumber program: aProgramNumber codes: anArray [
	"sent new codes for the SSRs, command W"

	|  progFloorCode nibbles toSend hexDigits |
	progFloorCode := self requestForFloor: aFloorNumber  program: aProgramNumber .
	hexDigits := '0123456789ABCDEF'.
	nibbles := ByteArray new: 12.
	1 to: 12 do: [ :i | nibbles at: i put: (anArray at: 4 * i - 3) + (2 *(anArray at: 4 * i - 2)) +
												(4 * (anArray at: 4 * i - 1)) + (8 * (anArray at: 4 * i))].
	toSend := nibbles collect: [  :each | hexDigits at: (each + 1) ] as: String.
	port nextPutAll: 'X', progFloorCode , toSend, Character linefeed asString.
]

{ #category : #reading }
MaHomeComms >> setpointsForFloor: aFloorNumber program: aProgramNumber [
	"read the setpoints for a given floor and program
	return the coded points (0-15)
	to do: checksum"

	| response c request map checksum |
	map := '0123456789ABCDEF'.
	

	request := 'V', (self requestForFloor: aFloorNumber program: aProgramNumber), Character linefeed asString.
	port nextPutAll: request .
	(Delay forMilliseconds: 400) wait.
	c := port readByteArray .
	response := Array new: 48.
	checksum := 0.
	1 to: 48 do: [ :i | response at: i put: (map indexOf: (c at: i) asCharacter) - 1  ].
	^response
]

{ #category : #'as yet unclassified' }
MaHomeComms >> ssrSetpointsForFloor: aFloorNumber program: aProgramNumber [
	"read the SSR setpoints/ return a bytearray of ones and zeroes"

	|  request c cc result hexDigits |
	hexDigits := '0123456789ABCDEF' asByteArray.
	request := 'O', (self requestForFloor: aFloorNumber program: aProgramNumber), Character linefeed asString.
	port nextPutAll: request .
	(Delay forMilliseconds: 400) wait.
	c := port readByteArray .
	
	cc := c collect: [ :each | (hexDigits indexOf: each) - 1  ] from: 1 to: 12.
	result := Array new: 48.
	1 to: 48 do: [  :i | result at: i put:
			 ((cc at: ((i - 1 )// 4 + 1)) bitAt: ( (i - 1) \\ 4 + 1))].
	^result
]

{ #category : #reading }
MaHomeComms >> ssrs [
	"read the status of the SSRs with the S command
	answer chracterstring of the chars U(it) A(an) O(verridden)"

	| t |
	port nextPutAll: #(83 10) asByteArray.
	(Delay forMilliseconds: 400) wait.
	t := port readByteArray.
	^t asString
]

{ #category : #helper }
MaHomeComms >> tempFromCode: aCodeNumber [
	"cconvert a coded temp to the actual temp"

	aCodeNumber = 0 ifTrue: [ ^ 0 ].
	aCodeNumber = 1 ifTrue: [ ^5 ].
	aCodeNumber = 2 ifTrue: [ ^10 ].
	aCodeNumber > 2 ifTrue: [ ^aCodeNumber + 12 ].
]

{ #category : #reading }
MaHomeComms >> temperatures [
	"The T command returns a string of 5 temperatures"

	| response temps|
	port nextPutAll: #(84 10) asByteArray .
	(Delay forMilliseconds: 400) wait.
	response := port readByteArray .
	temps := response asString substrings .
	^temps collect: [ :each | each asNumber asFloat ]
]
