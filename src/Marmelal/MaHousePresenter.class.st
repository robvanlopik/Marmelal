Class {
	#name : #MaHousePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'kitchen',
		'sitting',
		'diner',
		'sleep',
		'harpsi',
		'plateau',
		'hall',
		'bath',
		'currents'
	],
	#category : #Marmelal
}

{ #category : #specs }
MaHousePresenter class >> defaultSpec [
	^SpGridLayout new 
	beRowHomogeneous;
	beColumnHomogeneous ;
	add: #bath at: 1@1;
	add: #sitting at: 2@1;
	add: #plateau at: 3@1;
	add: #hall at: 4@1;
	add: #sleep at: 1@2;
	add: #kitchen at: 2@2;
	add: #currents at: 3@2;
	add: #diner at: 4@2;
	yourself
]

{ #category : #layout }
MaHousePresenter >> defaultLayout [
	^SpGridLayout new 
	beRowHomogeneous;
	beColumnHomogeneous ;
	add: #bath at: 1@1;
	add: #sitting at: 2@1;
	add: #plateau at: 3@1;
	add: #hall at: 4@1;
	add: #sleep at: 1@2;
	add: #kitchen at: 2@2;
	add: #currents at: 3@2;
	add: #diner at: 4@2;
	yourself
]

{ #category : #accessing }
MaHousePresenter >> diner [
	^ diner
]

{ #category : #accessing }
MaHousePresenter >> diner: anObject [
	diner := anObject
]

{ #category : #accessing }
MaHousePresenter >> harpsi [
	^ harpsi
]

{ #category : #accessing }
MaHousePresenter >> harpsi: anObject [
	harpsi := anObject
]

{ #category : #initialization }
MaHousePresenter >> initializePresenters [ 
	kitchen := self instantiate: MaFloorPresenter.
	sitting := self instantiate: MaFloorPresenter .
	diner := self instantiate: MaFloorPresenter .
	plateau := self instantiate: MaFloorPresenter.
	sleep := self instantiate: MaFloorPresenter.
	hall := self instantiate: MaSSRPresenter.
	bath := self instantiate: MaSSRPresenter.
	currents := self instantiate: MaCurrentPresenter.
	
	kitchen name label: 'keuken'.
	kitchen temp label: '22.3'.
	kitchen setPoint label: '20'.
	kitchen ssrState color: Color green.
	sitting name label: 'zitkamer'.
	diner name label: 'eetkamer'.
	plateau name label: 'plateau'.
	sleep name label: 'slaapkamer'.
	hall name label: 'kantoor'.
	bath name label: 'badkamer'.
	currents name label: 'stromen(A)'.
]

{ #category : #initialization }
MaHousePresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter 	
		title: 'Bulhe';
		initialExtent: 700@350
]

{ #category : #accessing }
MaHousePresenter >> kitchen [
	^ kitchen
]

{ #category : #accessing }
MaHousePresenter >> kitchen: anObject [
	kitchen := anObject
]

{ #category : #accessing }
MaHousePresenter >> sitting [
	^ sitting
]

{ #category : #accessing }
MaHousePresenter >> sitting: anObject [
	sitting := anObject
]

{ #category : #accessing }
MaHousePresenter >> sleep [
	^ sleep
]

{ #category : #accessing }
MaHousePresenter >> sleep: anObject [
	sleep := anObject
]

{ #category : #initialization }
MaHousePresenter >> updatePresenter [
	| house |
	house := self application house.
	"floor temps "
	kitchen temp label: (house floors at: 1) temp printString.
	sitting temp label: (house floors at: 2) temp printString.
	diner temp label: (house floors at: 3) temp printString.
	plateau temp label: (house floors at: 4) temp printString.
	sleep temp label: (house floors at: 5) temp printString.
	"floor setpoints"
	kitchen setPoint label: (house floors at: 1) setpoint printString.
	sitting setPoint label: (house floors at: 2) setpoint printString.
	diner setPoint  label: (house floors at: 3) setpoint printString.
	plateau setPoint  label: (house floors at: 4) setpoint printString.
	sleep setPoint label: (house floors at: 5) setpoint printString.
	"floor ssr states"
	kitchen ssrState color: (house floors at: 1) ssrStateAsColor .
	sitting  ssrState color: (house floors at: 2) ssrStateAsColor .
	diner ssrState color: (house floors at: 3) ssrStateAsColor .
	plateau ssrState color: (house floors at: 4) ssrStateAsColor .
	sleep ssrState color: (house floors at: 5) ssrStateAsColor .
	
	"currents"
	currents phaseA label: (house currents at: 1) printString.
	currents phaseB label: ( house currents at: 2 )printString.
	currents phaseC label: (house currents at: 3) printString.
]
