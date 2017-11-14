"
I'm an abstract class representing a key combination. I'm can represent several cases of key presses:

- simple key presses: pressing a single key, as a letter or number, or others like tab or space
- modified key presses: a simple key + a modifier like shift or alt
- option key presses: a list of key presses where only one of them should be valid
- chained shortcuts: a sequence of shortcuts

My more important protocols are:

- matching: contains methods to control if a key combination is equals to other or matches a sequence of keyboard events
- combining: defines simple ways to combine shorcut objects, like chaining them or modifying them

For more information, look at my subclasses.
"
Class {
	#name : #KMKeyCombination,
	#superclass : #Object,
	#category : #Keymapping-KeyCombinations
}

{ #category : #'instance creation' }
KMKeyCombination class >> fromKeyboardEvent: evt [
	| modifier control command shift alt |
	control := evt controlKeyPressed.
	command := evt commandKeyPressed.
	shift := evt shiftPressed.
	alt := evt altKeyPressed.
	(shift | command | control | alt)
		ifFalse: [^ KMSingleKeyCombination from: evt modifiedCharacter ].
	modifier := KMNoShortcut new.
	control
		ifTrue: [ modifier := modifier + KMModifier ctrl ].
	command
		ifTrue: [ modifier := modifier + KMModifier command ].
	shift
		ifTrue: [ modifier := modifier + KMModifier shift ].
	alt
		ifTrue: [ modifier := modifier + KMModifier alt ].
	^ modifier + evt modifiedCharacter
]

{ #category : #combining }
KMKeyCombination >> , aShortcut [
	^ KMKeyCombinationSequence first: self next: aShortcut asKeyCombination
]

{ #category : #comparing }
KMKeyCombination >> = aShortcut [
	^ aShortcut isKindOf: self species
]

{ #category : #converting }
KMKeyCombination >> asKeyCombination [
	^self
]

{ #category : #converting }
KMKeyCombination >> asShortcut [
	^ self asKeyCombination
]

{ #category : #iterating }
KMKeyCombination >> combinationsDo: aBlock [
	aBlock value: self
]

{ #category : #comparing }
KMKeyCombination >> hash [
	^ self species hash
]

{ #category : #matching }
KMKeyCombination >> includes: aShortcut [
	^self = aShortcut
]

{ #category : #combining }
KMKeyCombination >> mac [
	^KMPlatformSpecificKeyCombination with: self onPlatform: #MacOSX
]

{ #category : #matching }
KMKeyCombination >> matches: anEventBuffer [
	^ self matchesCompletely: anEventBuffer first
]

{ #category : #matching }
KMKeyCombination >> matchesCompletely: aKeyboardEvent [
	^ self = aKeyboardEvent asKeyCombination
]

{ #category : #'keymap building' }
KMKeyCombination >> named: keymapName do: anActionBlock [
	^ KMKeymap
		named: keymapName
		shortcut: self
		action: anActionBlock
]

{ #category : #'keymap building' }
KMKeyCombination >> named: keymapName do: anActionBlock withDescription: aDescription [
	^ KMKeymap
		named: keymapName
		shortcut: self
		action: anActionBlock
		description: aDescription
]

{ #category : #accessing }
KMKeyCombination >> platform [
	^#all
]

{ #category : #printing }
KMKeyCombination >> prettyPrintOn: aStream [

	aStream << self shortcut modifier symbol.
	self shortcut character printOn: aStream
]

{ #category : #accessing }
KMKeyCombination >> shortcut [
	^self
]

{ #category : #combining }
KMKeyCombination >> unix [
	^KMPlatformSpecificKeyCombination with: self onPlatform: #Unix
]

{ #category : #'keymap building' }
KMKeyCombination >> value: aBuilder [
	^ self
]

{ #category : #combining }
KMKeyCombination >> win [
	^KMPlatformSpecificKeyCombination with: self onPlatform: #Windows
]

{ #category : #combining }
KMKeyCombination >> | aShortcut [
	^KMKeyCombinationChoice withShortcuts: { self . aShortcut }
]