@isTest
private class TH_AccountUpdateParentQueueableTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static final String defaultName = 'Test Account';
	private static final String parentName = 'Parent';
	private static final Integer testNumberOfChildAccounts = 100;
	
	@testSetup() 
	static void setup() {
		List<Account> accountList = MOCK2_AccountFactory.createList(
			new Account(), 
			testNumberOfChildAccounts + 1, 
			defaultName,
			TEST_DummyInsertModeEnum.LATER
		);
		accountList[0].name = parentName;
		TEST_DMLHelper.doInsert(accountList, TEST_DummyInsertModeEnum.REAL);
	} 
	
	
	@isTest static void testAccountsUpdateByQueueable(){
		// Arrange
		String likeness = defaultName + '%';
		List<Account> accountList = [SELECT id FROM Account WHERE name LIKE :likeness];
		Id parentId = [SELECT id FROM Account WHERE name = :parentName][0].id;
		TH_AccountUpdateParentQueueable updater = new TH_AccountUpdateParentQueueable(accountList, parentId);
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
            	System.enqueueJob(updater);
            }
            Test.stopTest();
        }

		// Assert
		Integer updatedCount = [SELECT count() FROM Account WHERE parentId = :parentId];
		System.assertEquals(testNumberOfChildAccounts, updatedCount);
	}
}