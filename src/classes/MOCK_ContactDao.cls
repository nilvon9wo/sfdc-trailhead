@isTest
public class MOCK_ContactDao extends DAO_ContactDao {
	public static Boolean insertedContactList = false;
	public static Boolean updatedContactList = false;
	public static Boolean deletedContactList = false;
	public static Boolean gotContactList = false;
	
	
	public static List<Contact> resultContactList;
	
	public override UTIL_ResultListWrapper doInsert(List<Contact> contactList){
		insertedContactList = true;
		TEST_MockDMLHelper.mockInsert  ( contactList );
		return new UTIL_ResultListWrapper(
			new List<Database.SaveResult>()
		);
	}  

	public override UTIL_ResultListWrapper doUpdate(List<Contact> contactList){
		updatedContactList = true;
		return new UTIL_ResultListWrapper(
			new List<Database.UpsertResult>()
		); 
	}  

	public override UTIL_ResultListWrapper doDelete(List<Contact> contactList){
		deletedContactList = true;
		return new UTIL_ResultListWrapper(
			new List<Database.DeleteResult>()
		); 
	}  
	
	public override List<Contact> getByLastName(String lastName) {
		gotContactList = true;
		return resultContactList;
	}  
}