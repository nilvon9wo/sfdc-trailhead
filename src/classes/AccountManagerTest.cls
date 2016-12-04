@isTest
private class AccountManagerTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create();
	private static final String baseUri = 'https://eu11.salesforce.com/services/apexrest/Accounts/'; 
	
	@isTest static void testGetAccountById(){
		// Arrange
		Integer testNumberOfContacts = 3;
		Id testAccountId = MOCK_AccountFactory.createWithContactList(1, testNumberOfContacts, TEST_DummyInsertModeEnum.REAL).
			get(Account.getSObjectType())[0].
			id;
		RestRequest request = new RestRequest();
		request.requestUri = baseUri + testAccountId;
		request.httpMethod = 'GET';
		RestContext.request = request;

		// Act
		Account resultAccount;
        System.runAs(TestRunner){ 
            Test.startTest();
            {
           		resultAccount = AccountManager.getAccount(); 
            }
            Test.stopTest();
        }

		// Assert
		System.assertNotEquals(null, resultAccount);
		System.assertEquals(testNumberOfContacts, resultAccount.contacts.size());
	}
}