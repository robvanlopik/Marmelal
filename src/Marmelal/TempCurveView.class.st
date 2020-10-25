Class {
	#name : #TempCurveView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tempCurve',
		'left',
		'up',
		'down',
		'right',
		'ok',
		'quit'
	],
	#category : #Marmelal
}

{ #category : #specs }
TempCurveView class >> defaultSpec [

	^SpecColumnLayout composed
		newRow: [ :row | row add: #tempCurve width: 500 ] height: 360;
		newRow: [ :row | row add: #left; add: #down; add: #up; add: #right; add: #ok;  add: #quit] height: 83;
		yourself
]

{ #category : #accessing }
TempCurveView >> down [
	^ down
]

{ #category : #accessing }
TempCurveView >> down: anObject [
	down := anObject
]

{ #category : #initialization }
TempCurveView >> initializePresenter [ 

	left action: [ tempCurve widget previousTime  ].
	down action: [ tempCurve widget decrement ].
	up action: [ tempCurve widget increment ].
	right action: [ tempCurve widget nextTime ].
	quit action: [ self window close ].
]

{ #category : #initialization }
TempCurveView >> initializeWidgets [
	
	tempCurve := Tchart new asSpecAdapter .
	
	left := self newButton
		icon: (self iconNamed: #back)
		yourself.
	down := self newButton
		icon: (self iconNamed: #down).
	up := self newButton
		icon: (self iconNamed: #up ).
	right := self newButton
		icon: (self iconNamed: #forward).
	ok := self newButton
		label: 'OK'.
	quit := self newButton
		label: 'Quit'.
		
]

{ #category : #accessing }
TempCurveView >> left [
	^ left
]

{ #category : #accessing }
TempCurveView >> left: anObject [
	left := anObject
]

{ #category : #accessing }
TempCurveView >> ok [
	^ ok
]

{ #category : #accessing }
TempCurveView >> ok: anObject [
	ok := anObject
]

{ #category : #accessing }
TempCurveView >> quit [
	^ quit
]

{ #category : #accessing }
TempCurveView >> quit: anObject [
	quit := anObject
]

{ #category : #accessing }
TempCurveView >> right [
	^ right
]

{ #category : #accessing }
TempCurveView >> right: anObject [
	right := anObject
]

{ #category : #accessing }
TempCurveView >> tempCurve [
	^ tempCurve
]

{ #category : #accessing }
TempCurveView >> tempCurve: anObject [
	tempCurve := anObject
]

{ #category : #accessing }
TempCurveView >> up [
	^ up
]

{ #category : #accessing }
TempCurveView >> up: anObject [
	up := anObject
]
