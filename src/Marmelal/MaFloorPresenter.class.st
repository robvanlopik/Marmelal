Class {
	#name : #MaFloorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'name',
		'temp',
		'setPoint',
		'ssrState'
	],
	#category : #Marmelal
}

{ #category : #specs }
MaFloorPresenter class >> defaultSpec [ 
	^SpBoxLayout newVertical
	beHomogeneous;
		add: (SpBoxLayout newHorizontal
				hAlignCenter;
				add: #name height: 30 ;
				yourself) height: 30;
		add: #temp height: 30;
		add: #setPoint height: 30;
		add: #ssrState expand: false  ;
		yourself

]

{ #category : #layout }
MaFloorPresenter >> defaultLayout [
	^SpBoxLayout newVertical
	beHomogeneous;
		add: (SpBoxLayout newHorizontal
				hAlignCenter;
				add: #name height: 30 ;
				yourself) height: 30;
		add: #temp height: 30;
		add: #setPoint height: 30;
		add: #ssrState expand: false  ;
		yourself

]

{ #category : #initialization }
MaFloorPresenter >> initializePresenters [ 
	name := self newLabel.
	temp := self newLabel.
	setPoint := self newLabel.
	ssrState := self newMorph.
	ssrState morph: MaIndicator new
]

{ #category : #accessing }
MaFloorPresenter >> name [
	^ name
]

{ #category : #accessing }
MaFloorPresenter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MaFloorPresenter >> setPoint [
	^ setPoint
]

{ #category : #accessing }
MaFloorPresenter >> setPoint: anObject [
	setPoint := anObject
]

{ #category : #accessing }
MaFloorPresenter >> ssrState [
	^ ssrState
]

{ #category : #accessing }
MaFloorPresenter >> ssrState: anObject [
	ssrState := anObject
]

{ #category : #accessing }
MaFloorPresenter >> temp [
	^ temp
]

{ #category : #accessing }
MaFloorPresenter >> temp: anObject [
	temp := anObject
]
