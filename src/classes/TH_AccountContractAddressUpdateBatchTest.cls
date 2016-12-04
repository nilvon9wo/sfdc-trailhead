@isTest
private class TH_AccountContractAddressUpdateBatchTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create();

	private static final Integer numberOfAccounts = 10;
	
	@testSetup() 
	static void setup() {
		Account templateAccount = new Account(billingCity = 'New York', billingCountry = 'USA');
		List<Account> accountList = MOCK2_AccountFactory.createList(templateAccount, numberOfAccounts, TEST_DummyInsertModeEnum.REAL);		
		
		Integer numberOfContactsPerAccount = 1;
		MOCK2_ContactFactory.createList(new Contact(), numberOfContactsPerAccount, accountList, TEST_DummyInsertModeEnum.REAL);
	} 
	 
	@isTest static void testContactsAreSyncedToBillingAddresses(){
		// Arrange
		TH_AccountContractAddressUpdateBatchable batchableUnderTest = new TH_AccountContractAddressUpdateBatchable();
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
            	Database.executeBatch(batchableUnderTest);
            }
            Test.stopTest();
        }

		// Assert
		Integer resultCount = [SELECT count() FROM Contact WHERE MailingCity = 'New York'];
		System.assertEquals(numberOfAccounts, resultCount);
	}
}