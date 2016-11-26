@isTest
public class MOCK_ContactDao extends DAO_ContactDao {
	public override UTIL_ResultListWrapper doInsert(List<Contact> contactList){
		TEST_MockDMLHelper.mockInsert  ( contactList );
		return new UTIL_ResultListWrapper(
			new List<Database.SaveResult>()
		);
	}  

	public override UTIL_ResultListWrapper doUpdate(List<Contact> contactList){
		// TODO: Flag updated data without potentially corrupting data we want to perpetuate
		return new UTIL_ResultListWrapper(
			new List<Database.UpsertResult>()
		); 
	}  
}