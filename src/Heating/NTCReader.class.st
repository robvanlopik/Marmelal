Class {
	#name : #NTCReader,
	#superclass : #Object,
	#instVars : [
		'esp32driver',
		'refSpanning',
		'vasteWeerstand'
	],
	#category : #Heating
}

{ #category : #'as yet unclassified' }
NTCReader >> doeMetingOpPin: pinNr [

	^1.7
]

{ #category : #accessing }
NTCReader >> esp32driver [

	^ esp32driver
]

{ #category : #accessing }
NTCReader >> esp32driver: anObject [

	esp32driver := anObject
]

{ #category : #initialization }
NTCReader >> initialize [
	refSpanning := 3.4.
	vasteWeerstand := 13.75
]

{ #category : #accessing }
NTCReader >> refSpanning [

	^ refSpanning
]

{ #category : #accessing }
NTCReader >> refSpanning: anObject [

	refSpanning := anObject
]

{ #category : #accessing }
NTCReader >> vasteWeerstand [

	^ vasteWeerstand
]

{ #category : #accessing }
NTCReader >> vasteWeerstand: anObject [

	vasteWeerstand := anObject
]

{ #category : #'as yet unclassified' }
NTCReader >> weerstandOpPin: pinNr [
	"bepaal de weerstand op pin pinNr"
	| meting |
	
	meting := self doeMetingOpPin: pinNr.
	^vasteWeerstand / (( refSpanning  / meting) - 1)
]
