Class {
	#name : 'MaSetpointPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'graph',
		'left',
		'down',
		'up',
		'right',
		'ok',
		'quit'
	],
	#category : 'Marmelal-Spec',
	#package : 'Marmelal',
	#tag : 'Spec'
}

{ #category : 'specs' }
MaSetpointPresenter class >> defaultSpec [ 	
	^SpBoxLayout newVertical
		add: #graph height: 400;
		add: 
		(SpBoxLayout newHorizontal
		add: #left;
		add: #up;
		add: #down;
		add: #right;
		add: #ok;
		add: #quit;
		yourself);
		yourself
]

{ #category : 'initialization' }
MaSetpointPresenter >> connectPresenters [
	left action: [  graph morph previousTime  ].
	right action: [ graph morph nextTime ].
	up action: [ graph morph increment ].
	down action: [ graph morph decrement  ].
	quit action: [ self window close ].
	
]

{ #category : 'layout' }
MaSetpointPresenter >> defaultLayout [
	^SpBoxLayout newVertical
		add: #graph height: 400;
		add: 
		(SpBoxLayout newHorizontal
		add: #left;
		add: #up;
		add: #down;
		add: #right;
		add: #ok;
		add: #quit;
		yourself);
		yourself
]

{ #category : 'accessing' }
MaSetpointPresenter >> down [
	^ down
]

{ #category : 'accessing' }
MaSetpointPresenter >> down: anObject [
	down := anObject
]

{ #category : 'accessing' }
MaSetpointPresenter >> graph [
	^ graph
]

{ #category : 'accessing' }
MaSetpointPresenter >> graph: anObject [
	graph := anObject
]

{ #category : 'initialization' }
MaSetpointPresenter >> initializePresenters [ 	
	graph := self newMorph.
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
	
	graph morph: Tchart new
		
]

{ #category : 'initialization' }
MaSetpointPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'setpoints';
		initialExtent: 600@550
]

{ #category : 'accessing' }
MaSetpointPresenter >> left [
	^ left
]

{ #category : 'accessing' }
MaSetpointPresenter >> left: anObject [
	left := anObject
]

{ #category : 'accessing' }
MaSetpointPresenter >> ok [
	^ ok
]

{ #category : 'accessing' }
MaSetpointPresenter >> ok: anObject [
	ok := anObject
]

{ #category : 'accessing' }
MaSetpointPresenter >> quit [
	^ quit
]

{ #category : 'accessing' }
MaSetpointPresenter >> quit: anObject [
	quit := anObject
]

{ #category : 'accessing' }
MaSetpointPresenter >> right [
	^ right
]

{ #category : 'accessing' }
MaSetpointPresenter >> right: anObject [
	right := anObject
]

{ #category : 'accessing' }
MaSetpointPresenter >> up [
	^ up
]

{ #category : 'accessing' }
MaSetpointPresenter >> up: anObject [
	up := anObject
]
