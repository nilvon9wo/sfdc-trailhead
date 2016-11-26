@isTest
public class MOCK_AccountDao extends DAO_AccountDao {
	public override UTIL_ResultListWrapper doInsert(Account account){
		TEST_MockDMLHelper.mockInsert  ( account );
		return new UTIL_ResultListWrapper(
			new List<Database.SaveResult>()
		);
	}  
}