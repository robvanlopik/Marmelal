Class {
	#name : #MaWebserver,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'house'
	],
	#category : 'Marmelal-Comms'
}

{ #category : #'instance creation' }
MaWebserver class >> newOn: aHouse [
	^self new on: aHouse
]

{ #category : #accessing }
MaWebserver >> house [
	^house
]

{ #category : #'as yet unclassified' }
MaWebserver >> installStatus [
	teapot GET: '/status' -> [  :x | self status ]
]

{ #category : #'as yet unclassified' }
MaWebserver >> keuken [
 teapot GET: '/keuken' -> [ :w | (self house floors at: 1) tempAsString, ' ', (self house ssrs at: 1) ]
]

{ #category : #'instance creation' }
MaWebserver >> on: aHouse [
	house := aHouse
]

{ #category : #accessing }
MaWebserver >> start [
	teapot ifNil: [ teapot := Teapot on 
		GET: '/welcome' -> 'I am the viewer'; 
		GET: '/test' -> [  :r | self test];
		GET: '/status' -> [  :x | self status ]; start ]
]

{ #category : #accessing }
MaWebserver >> status [
	" return a html string describing a table with header -plaats|temp|ssr- and 
	the respective values"
	| t floors |
	
floors := self house floors.

t := ZnHtmlOutputStream streamContents: [  :html |
	html page: 'Status' do: [
		html tag: #br.
		html tag: #table do: [
			html tag: #tr do: [
				html tag: #th with: 'loc'.
				html tag: #th with: 'temp'.
				html tag: #th with: 'ssr' ].
			#(1 2 3 4 5) do: [  :i |
				
			html tag: #tr do: [ 
				html tag: #td with: (floors at: i) name.
				html tag: #td with: (floors at: i) tempAsString.
				html tag: #td with: (house ssrs at: i) state asString].
			]].
		html tag: #br.
		html tag: #b with: 'stromen:'.
		html tag: #br.
		html str: (((house currents at: 1) printShowingDecimalPlaces: 1) , ' | ' ,
					 ((house currents at: 2) printShowingDecimalPlaces: 1) , ' | ' ,
					 ((house currents at: 3) printShowingDecimalPlaces: 1 )).
	]
].
	^t
]

{ #category : #accessing }
MaWebserver >> teapot [
	^teapot
]

{ #category : #accessing }
MaWebserver >> test [
	^'test'
]
