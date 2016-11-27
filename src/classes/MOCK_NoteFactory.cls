@isTest
public class MOCK_NoteFactory { 
	public static List<Note> createList(fflib_SObjectUnitOfWork unitOfWork, List<SObject> sObjectList) {
		List<Note> noteList = new List<Note>();
		for (SObject sObj : sObjectList) { 
			noteList.add(create(unitOfWork, sObj)); 
		}
		return noteList;
	}
	
	public static Note create(fflib_SObjectUnitOfWork unitOfWork, SObject sObj) {
		Id parentId = sObj.id;
		Note note = new Note(
			title = 'Challange Complete Test Note for ' + parentId,
			body = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum tortor id rhoncus. Maecenas vitae tristique lorem. Vivamus et ullamcorper lorem. Curabitur feugiat rhoncus nisl eu ullamcorper. Sed sed rutrum arcu. Vestibulum nibh quam, finibus ac eleifend quis, porta ac ex. Mauris nec turpis porttitor, accumsan ex id, laoreet erat. Nunc ut est urna. Integer accumsan tincidunt ex nec condimentum. Sed fringilla justo a diam efficitur, sit amet convallis mi eleifend. Mauris tincidunt dui non libero maximus, sit amet maximus risus facilisis. Nam blandit, lectus et cursus posuere, quam dui malesuada nisi, et condimentum lacus dui non turpis.',
			parentId = parentId
		);
		Schema.sObjectField relatedField = Schema.SObjectType.Note.fields.parentId.getSObjectField();
		unitOfWork.registerNew(note, relatedField, sObj);  
		return note;
	}
}