@isTest
public class MOCK_AccountDao extends DAO_AccountDao {
	public static Boolean insertedAccount = false;
	public override UTIL_ResultListWrapper doInsert(Account account){
		insertedAccount = true;
		TEST_MockDMLHelper.mockInsert  ( account );
		return new UTIL_ResultListWrapper(
			new List<Database.SaveResult>()
		);
	}  
}