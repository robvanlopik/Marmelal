Class {
	#name : #StRootComponent,
	#superclass : #WAComponent,
	#category : #Marmelal
}

{ #category : #testing }
StRootComponent class >> canBeRoot [
	^true
]

{ #category : #rendering }
StRootComponent >> renderContentOn: html [
	html text: 'zomaarwat'.
	html break.
	html text: Date today
]
