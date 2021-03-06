"
I am an example of use of Hiedra in the Spec library (with Morph as backend).
"
Class {
	#name : #HiSpecExample,
	#superclass : #ComposablePresenter,
	#instVars : [
		'hiedraColumnController',
		'table'
	],
	#category : #'Hiedra-UI-Examples'
}

{ #category : #specs }
HiSpecExample class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #table;
		yourself
]

{ #category : #specs }
HiSpecExample class >> example2870IcebergCommits [
	self openExample: #iceberg_v1_5_6
]

{ #category : #specs }
HiSpecExample class >> example493PharoCommits [
	self openExample: #pharo_v60507
]

{ #category : #specs }
HiSpecExample class >> example60RandomCommits [
	self openExample: #randomlyGenerated
]

{ #category : #specs }
HiSpecExample class >> openExample: selector [

	| commits |
	commits := HiExampleCommit perform: selector.

	self new
		commits: commits;
		title: ('Hiedra in Spec - {1} - {2} elements' format: {selector. commits size});
		extent: 500 @ 700;
		openWithSpec
]

{ #category : #accessing }
HiSpecExample >> commits: commits [ 

	table items: commits.

	hiedraColumnController ruler: (HiRulerBuilder 
		newRulerValues: commits
		linksBlock: [:aCommit |
			aCommit parentIds collect: [:id | 
				commits detect: [:each | each id = id ] ] ]).

	hiedraColumnController reset.
	
	"After #reset, we can know the width of the column."
	table columns first width: hiedraColumnController rulerWidth.
]

{ #category : #initialization }
HiSpecExample >> initializeWidgets [
	
	table := self instantiate: TablePresenter.

	"Configure hiedra controller"
	hiedraColumnController := HiColumnController new.	

	hiedraColumnController renderer
		nodeRadius: 1.5;
		nodeBorderWidth: 3.0;
		arrowSize: 0;
		nodeConnectionOffset: 3;
		cellWidth: 8;
		nodeColor: Smalltalk ui theme textColor.
	
	"Adjust the ruler rendering settings with table's row height."
	hiedraColumnController renderer rowHeight: FTTableMorph defaultRowHeight floor.

	"Configure columns"
	table columns:	{
		ImageTableColumn evaluated: [ :item |
			hiedraColumnController cellMorphAtValue: item ].
		StringTableColumn evaluated: #comment.
	}.

]

{ #category : #accessing }
HiSpecExample >> table [
	^ table
]
