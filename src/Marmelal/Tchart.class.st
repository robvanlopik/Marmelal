Class {
	#name : #Tchart,
	#superclass : #BorderedMorph,
	#instVars : [
		'tbars',
		'activeBar',
		'timeLabel',
		'tempLabel'
	],
	#category : #Marmelal
}

{ #category : #accessing }
Tchart >> activeBar [
	^ activeBar
]

{ #category : #accessing }
Tchart >> activeBar: aNumber [
	| old |
	old := self activeBar .
	(old = aNumber) ifTrue: [ ^self ].
	activeBar := aNumber.
	(self tbars at: old) color: Color paleBlue darker.
	(self tbars at: aNumber) color: Color red.
	self changed 
	
]

{ #category : #API }
Tchart >> decrement [
	"increment the tempCode at the active bar"
	
	| t b |
	b := tbars at: activeBar.
	t := b tempCode .
	t = 0 ifTrue: [ ^0 ].
	b tempCode: (t - 1).
	b position: (self position x + ((activeBar - 1) * 10)) @ ((self position y) + (self height - (20 * b tempCode))).
	b extent: 10 @ (20 * b tempCode).
	self tempLabel contents: (self tbars at: activeBar) realTemp asString. 
]

{ #category : #accessing }
Tchart >> increment [
	"increment the tempCode at the active bar"
	
	| t b |
	b := tbars at: activeBar.
	t := b tempCode .
	t = 15 ifTrue: [ ^15 ].
	b tempCode: (t + 1).
	b position: (self position x + ((activeBar - 1) * 10)) @ ((self position y) + (self height - (20 * b tempCode))).
	b extent: 10 @ (20 * b tempCode).
	self tempLabel contents: (self tbars at: activeBar) realTemp asString. 
]

{ #category : #'as yet unclassified' }
Tchart >> incrementActive [

	self activeBar = 15 ifTrue: [ ^nil ].
]

{ #category : #initialization }
Tchart >> initBars [
	"create the barsand add them to tbars and to self"
		
	1 to: 48 do: [ :index | | bar | 
		bar := Tbar new .
		self tbars at: index put: bar.
		self addMorph: bar.
		 ]
]

{ #category : #initialization }
Tchart >> initLegenda [
	| time temp |
	
	time := TextMorph new.
	time contents: 'time'.
	time position: self position + (150 @5).
	self timeLabel: time.
	self addMorph: time.
	
	temp := TextMorph new.
	temp contents: 'temp'.
	temp position: self position + (300 @5 ).
	self tempLabel: temp.
	self addMorph: temp.
]

{ #category : #initialization }
Tchart >> initialize [ 
	super initialize.
	tbars := Array new: 48.
	self bounds: (5@5 corner: 485 @ (16*20 + 50)). 
	self color: Color white.
	activeBar := 24.
	self initBars.
	self initLegenda.
]

{ #category : #'as yet unclassified' }
Tchart >> loadWith: anArray active: aNumber [
"load the graph with a coded temp array and the active timeIndex (1..48)"
	
	self activeBar: aNumber.
	1 to: 48 do: [ :index | |bar |
		bar := tbars at: index.
		bar tempCode: (anArray at: index).
		bar position: (self position x + ((index - 1) * 10)) @ ((self position y) + (self height - (20 * bar tempCode))).
		bar extent: 10 @ (20 * bar tempCode).
		].
	(tbars at: aNumber) color: Color red.
	self tempLabel contents: (tbars at: aNumber) realTemp asString.
	self timeLabel contents: self timeStringActive.
]

{ #category : #'instance creation' }
Tchart >> newTbarAt: aNumber [

	| tb origin|
	tb := Tbar new.
	origin := self innerBounds origin.
	tb position: ((aNumber - 1) *10) @ 100 + origin.
	self addMorph: tb.
	^tb
]

{ #category : #'instance creation' }
Tchart >> newTcodes [
	"return a collection with the new Temperature codes"
	| result |
	result := self tbars collect: [ :bar | bar tempCode ].
	^result
]

{ #category : #'as yet unclassified' }
Tchart >> nextTime [
	(tbars at: activeBar) color: Color paleBlue darker.
	activeBar := activeBar + 1.
	activeBar = 49 ifTrue: [ activeBar := 1 ].
	(tbars at: activeBar) color: Color red.
	self timeLabel contents: self timeStringActive .
	self tempLabel contents: (self tbars at: activeBar) realTemp asString. 

	
]

{ #category : #'as yet unclassified' }
Tchart >> previousTime [

	(tbars at: activeBar) color: Color paleBlue darker.
	activeBar := activeBar - 1.
	activeBar = 0 ifTrue: [ activeBar := 48 ].
	(tbars at: activeBar) color: Color red.
	self timeLabel contents: self timeStringActive .
	self tempLabel contents: (self tbars at: activeBar) realTemp asString. 
]

{ #category : #accessing }
Tchart >> tbars [
	^ tbars
]

{ #category : #accessing }
Tchart >> tbars: anObject [
	tbars := anObject
]

{ #category : #accessing }
Tchart >> tempLabel [
	^ tempLabel
]

{ #category : #accessing }
Tchart >> tempLabel: anObject [
	tempLabel := anObject
]

{ #category : #tests }
Tchart >> testArray [ 
	"return anArray uesful for testen"
	| t | 
	t := Array new: 48.
	1 to: 48 do: [  :i | t at: i put: (i \\ 16) ].
	^t
]

{ #category : #accessing }
Tchart >> timeLabel [
	^ timeLabel
]

{ #category : #accessing }
Tchart >> timeLabel: anObject [
	timeLabel := anObject
]

{ #category : #'as yet unclassified' }
Tchart >> timeStringActive [
	"return string representing time corresponding to active bar"
	
	|h m mm|
	
	h := ((self activeBar) -1) // 2.
	m := ((self activeBar) - 1) \\ 2.
	mm := '00'.
	m = 1 ifTrue: [ mm := '30' ].
	^(h asString, ':', mm)
]
