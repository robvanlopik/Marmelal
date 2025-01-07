"
I keep all parts of the home automation system together in my instance variables and offer methods to start them

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	doos1Serial:		<Object>
	house:		this is a model of the house with floors etc
	mqttlistener:		this listens to mqtt messages and updates the state of the house
	webApp:		this contains a webserver and reponds to web requests


    Implementation Points
"
Class {
	#name : #MaController,
	#superclass : #Object,
	#instVars : [
		'house',
		'webApp',
		'doos1Serial',
		'mqttlistener'
	],
	#category : 'Marmelal-Core'
}
