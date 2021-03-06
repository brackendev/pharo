"
Tests for BIConfigurableFormatter
"
Class {
	#name : #BIConfigurableFormatterFormattingTest,
	#superclass : #RBFormatterTest,
	#category : #'BlueInk-Tests-Base'
}

{ #category : #testing }
BIConfigurableFormatterFormattingTest class >> shouldInheritSelectors [
	
	^ true
]

{ #category : #private }
BIConfigurableFormatterFormattingTest >> formatterClass [
	^ BIConfigurableFormatter
]

{ #category : #tests }
BIConfigurableFormatterFormattingTest >> testShouldReinitializeCodeStreamBetweenFormating [
	|astNode formater context|
	context := BIPrettyPrinterContext new.
	formater := BIConfigurableFormatter new installNewContext: context.
	astNode := RBParser parseExpression: '1'.
	self assert: (formater format: astNode) equals: '1'
]
