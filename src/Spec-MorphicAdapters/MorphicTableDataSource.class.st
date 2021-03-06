"
I'm a dataSource to be used in MorphicTableAdapter to realise a TablePresenter.
I define my cells following the definition on columns (MorphicTableColumn).
I use a builder (MorphicTableCellBuilder) to realise the cell content. 
"
Class {
	#name : #MorphicTableDataSource,
	#superclass : #FTSimpleDataSource,
	#traits : 'TMorphicTableDataSourceCommons',
	#classTraits : 'TMorphicTableDataSourceCommons classTrait',
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #accessing }
MorphicTableDataSource >> cellColumn: column row: rowIndex [
	| cell builder |

	cell := FTCellMorph new.
	builder := MorphicTableCellBuilder on: self.
	builder 
		cell: cell;
		rowIndex: rowIndex;
		visit: column model.
		
	^ cell
]

{ #category : #accessing }
MorphicTableDataSource >> elements [ 
	
	^ self model 
		ifNotNil: #items
		ifNil: [ #() ]
]
