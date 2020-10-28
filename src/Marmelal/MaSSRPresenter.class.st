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
		add: #name height: 30;
		add: #ssrState height: 30;
		add: #setPoint height: 30;
		yourself.
		
]

{ #category : #initialization }
MaSSRPresenter >> initializePresenters [ 
	name := self newLabel.
	ssrState := self newMorph.
	setPoint := self newMorph.
	
	ssrState morph: MaIndicator new.
	setPoint	morph: MaIndicator new.

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
