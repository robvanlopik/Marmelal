Class {
	#name : #TempSensor,
	#superclass : #Object,
	#instVars : [
		'ntcTabel',
		'naam',
		'adcPin',
		'reader'
	],
	#category : #Heating
}

{ #category : #accessing }
TempSensor >> adcPin [

	^ adcPin
]

{ #category : #accessing }
TempSensor >> adcPin: anObject [

	adcPin := anObject
]

{ #category : #initialization }
TempSensor >> initialize [ 
	ntcTabel := #(23.36 22.3 21.29 20.34 19.43 18.57 17.75 16.97 16.24 15.54 14.87 
14.24 13.64 13.06 12.52 12.00 11.51 11.04 10.59 10.16 9.75)

]

{ #category : #accessing }
TempSensor >> naam [

	^ naam
]

{ #category : #accessing }
TempSensor >> naam: anObject [

	naam := anObject
]

{ #category : #accessing }
TempSensor >> ntcTabel [

	^ ntcTabel
]

{ #category : #accessing }
TempSensor >> ntcTabel: anObject [

	ntcTabel := anObject
]

{ #category : #accessing }
TempSensor >> reader [

	^ reader
]

{ #category : #accessing }
TempSensor >> reader: anObject [

	reader := anObject
]

{ #category : #'as yet unclassified' }
TempSensor >> temperatuur [
	"lees de weerstandwaarde en reken om tot temperatuur"	
	| weerstand index|
	
	weerstand := reader weerstandOpPin: adcPin.
	"eerst de extremen"
	(weerstand > ntcTabel first) ifTrue: [ ^-1.0 ].
	(weerstand < ntcTabel last) ifTrue: [  ^-2.0 ].
	index := ntcTabel findFirst: weerstand.
	
	
	

	
]
