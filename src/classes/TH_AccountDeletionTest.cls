@isTest
private class TH_AccountDeletionTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 

	private static Boolean SHOULD_SUCCEED = true;
	private static Boolean SHOULD_FAIL = false;
	
	@isTest static void deletingAccountWithOneOpportunityShouldFail(){
		testDeletingAccounts(1, 1, SHOULD_FAIL);
	}

	@isTest static void deletingAccountWithNoOpportunityShouldSucceed(){
		testDeletingAccounts(1, 0, SHOULD_SUCCEED);
	}

	@isTest static void deletingBulkAccountsWithOneOpportunityShouldFail(){
		testDeletingAccounts(200, 1, SHOULD_FAIL);
	}

	@isTest static void deletingBulkAccountsWithNoOpportunityShouldSucceed(){
		testDeletingAccounts(200, 0, SHOULD_SUCCEED);
	}

	static private void testDeletingAccounts(Integer numberOfAccounts, Integer numberOfOpportunities, Boolean shouldSucceed) {
		// Arrange
		Map<SObjectType, List<SObject>> sObjectListBySObjectMap = 
			MOCK_AccountFactory.createWithOpportunityList(numberOfAccounts, numberOfOpportunities, TEST_DummyInsertModeEnum.REAL);

		List<Account> accountList = sObjectListBySObjectMap.get(Account.getSObjectType());
		if (numberOfOpportunities == 0) {
			cleanOpportunitiesCreatedByAccountInsert(accountList);
		}

		Account testAccount = accountList[0];
		
		// Act
		Database.DeleteResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.delete(testAccount, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(shouldSucceed, result.isSuccess());
		if (!shouldSucceed) {
			System.assert(result.getErrors().size() > 0); 
			System.assertEquals(TH_Accounts.CANNOT_DELETE_WITN_OPPORTUNITIES, result.getErrors()[0].getMessage());
		}
	}
	
	static private void cleanOpportunitiesCreatedByAccountInsert(List<Account> accountList) {
		Database.delete([SELECT id FROM Opportunity WHERE accountId IN :accountList]);	
	}

}