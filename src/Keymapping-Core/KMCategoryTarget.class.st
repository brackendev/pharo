"
I am the reification of the relation morph<->category, created when a morph gets attached a category of shortcuts.
"
Class {
	#name : #KMCategoryTarget,
	#superclass : #Object,
	#instVars : [
		'target',
		'category',
		'morph'
	],
	#category : #Keymapping-Core
}

{ #category : #'instance creation' }
KMCategoryTarget class >> target: aTarget morph: aMorph category: aCategory [
	^self new
		target: aTarget;
		category: aCategory;
		morph: aMorph;
		yourself
]

{ #category : #accessing }
KMCategoryTarget >> category [

	^ category
]

{ #category : #accessing }
KMCategoryTarget >> category: aCategory [
	category := aCategory
]

{ #category : #matching }
KMCategoryTarget >> completeMatch: aKeymap buffer: aBuffer [
	KMLog logCompleteMatch: aKeymap.
	KMBuffer uniqueInstance completeMatch.
	aKeymap action cull: target value cull: morph cull: aBuffer first.

]

{ #category : #accessing }
KMCategoryTarget >> morph [

	^ morph
]

{ #category : #accessing }
KMCategoryTarget >> morph: aMorph [
	morph := aMorph
]

{ #category : #iterating }
KMCategoryTarget >> nextForKmChain: aKMDispatchChain [
	^self target
]

{ #category : #matching }
KMCategoryTarget >> noMatch [
	"do nothing"
	
]

{ #category : #matching }
KMCategoryTarget >> partialMatch [
	"do nothing"
	
]

{ #category : #printing }
KMCategoryTarget >> printOn: aStream [

	aStream
		nextPutAll: 'aKMCategoryTarget(';
		nextPutAll: (category name ifNil: 'nil' ifNotNil: [ :n | n printString ]);
		nextPutAll: ')'.
]

{ #category : #accessing }
KMCategoryTarget >> target [

	^ target
]

{ #category : #accessing }
KMCategoryTarget >> target: aTarget [
	target := aTarget
]

{ #category : #matching }
KMCategoryTarget >> verifyMatchWith: anEventBuffer notifying: aListener thenDoing: anAction [
	self flag: #fixme. "ugly hack with array of listeners"
	category 
		onMatchWith:  anEventBuffer
		notify: { self . aListener } " first we have to tell the dispatcher "
		andDo: anAction
]