Class {
	#name : #MaCurrentPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'name',
		'phaseA',
		'phaseB',
		'phaseC'
	],
	#category : #'Marmelal-Spec'
}

{ #category : #specs }
MaCurrentPresenter class >> defaultSpec [
	^SpBoxLayout newVertical 
		add: #name;
		add: #phaseA;
		add: #phaseB;
		add: #phaseC
]

{ #category : #layout }
MaCurrentPresenter >> defaultLayout [
	^SpBoxLayout newVertical 
		add: #name;
		add: #phaseA;
		add: #phaseB;
		add: #phaseC
]

{ #category : #initialization }
MaCurrentPresenter >> initializePresenters [ 
	name := self newLabel.
	phaseA := self newLabel.
	phaseB := self newLabel.
	phaseC := self newLabel.
]

{ #category : #accessing }
MaCurrentPresenter >> name [
	^ name
]

{ #category : #accessing }
MaCurrentPresenter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MaCurrentPresenter >> phaseA [
	^ phaseA
]

{ #category : #accessing }
MaCurrentPresenter >> phaseA: anObject [
	phaseA := anObject
]

{ #category : #accessing }
MaCurrentPresenter >> phaseB [
	^ phaseB
]

{ #category : #accessing }
MaCurrentPresenter >> phaseB: anObject [
	phaseB := anObject
]

{ #category : #accessing }
MaCurrentPresenter >> phaseC [
	^ phaseC
]

{ #category : #accessing }
MaCurrentPresenter >> phaseC: anObject [
	phaseC := anObject
]
