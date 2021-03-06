"
I am a command to install execution counter into given method or source node
"
Class {
	#name : #ClyAddExecutionCounterCommand,
	#superclass : #ClyMetalinkCommand,
	#category : #'Calypso-SystemPlugins-Reflectivity-Browser-ExecutionCounters'
}

{ #category : #execution }
ClyAddExecutionCounterCommand class >> canBeExecutedInContext: aBrowserContext [

	^aBrowserContext isSelectedItemHasExecutionCounter not
]

{ #category : #activation }
ClyAddExecutionCounterCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddExecutionCounterCommand >> defaultMenuIconName [
	^#classIcon
]

{ #category : #accessing }
ClyAddExecutionCounterCommand >> defaultMenuItemName [
	^'Add counter'
]

{ #category : #execution }
ClyAddExecutionCounterCommand >> execute [
	
	ExecutionCounter installOn: sourceNode
]
