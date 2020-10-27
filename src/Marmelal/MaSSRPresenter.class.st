Class {
	#name : #MaSSRPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'name',
		'ssrState',
		'setPoint'
	],
	#category : #Marmelal
}

{ #category : #specs }
MaSSRPresenter class >> defaultSpec [
		^SpBoxLayout newVertical
		add: #name;
		add: #ssrState;
		add: #setPoint.
		
]

{ #category : #initialization }
MaSSRPresenter >> initializePresenters [ 
	name := self newLabel.
	ssrState := self newMorph.
	setPoint := self newMorph.
	
	ssrState morph: CircleMorph new .
	setPoint morph: CircleMorph new.

]

{ #category : #accessing }
MaSSRPresenter >> name [
	^ name
]

{ #category : #accessing }
MaSSRPresenter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MaSSRPresenter >> setPoint [
	^ setPoint
]

{ #category : #accessing }
MaSSRPresenter >> setPoint: anObject [
	setPoint := anObject
]

{ #category : #accessing }
MaSSRPresenter >> ssrState [
	^ ssrState
]

{ #category : #accessing }
MaSSRPresenter >> ssrState: anObject [
	ssrState := anObject
]
