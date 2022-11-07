Class {
	#name : #HSTemperatureReader,
	#superclass : #Object,
	#instVars : [
		'doos2',
		'oldTemp',
		'coefficients'
	],
	#category : #Heating
}

{ #category : #initialization }
HSTemperatureReader >> initialize [ 
	coefficients := #( 911 753 622 512 422 348 288 239 199).
]
