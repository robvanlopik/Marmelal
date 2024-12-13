Class {
	#name : #Tbar,
	#superclass : #BorderedMorph,
	#instVars : [
		'tempCode'
	],
	#category : #'Marmelal-Spec'
}

{ #category : #'as yet unclassified' }
Tbar >> incrementTemp [
	|newTemp|
	self tempCode = 15 ifTrue: [ ^15 ].
	newTemp := self tempCode + 1.
	self tempCode: newTemp.
	self extent: (self extent + 10@10).
	^newTemp
]

{ #category : #initialization }
Tbar >> initialize [
 	super initialize .

	self color: Color paleBlue darker.
]

{ #category : #'as yet unclassified' }
Tbar >> realTemp [
	"returns the real temperature"
	| code |
	code := self tempCode.
	code = 0 ifTrue: [ ^0 ].
	code = 1 ifTrue: [ ^5 ].
	code = 2 ifTrue: [ ^10 ].
	code = 3 ifTrue: [  ^15 ].
	^(code + 12)
]

{ #category : #accessing }
Tbar >> tempCode [
	^ tempCode
]

{ #category : #accessing }
Tbar >> tempCode: anObject [
	tempCode := anObject
]

{ #category : #geometry }
Tbar >> width [ 
	^10
]
