@isTest
private class TH_AccountAddContactQueueTest {   
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static final String targetState = 'CA';
	private static final Integer numberOfAccountsInTarget = 50;
	private static final Map<String, Integer> numberOfAccountsByStateMap = new Map<String, Integer>{
		targetState => numberOfAccountsInTarget,
		'NY' => 50
	};  
	
	@testSetup() 
	static void setup() {
		List<Account> accountList = MOCK2_AccountFactory.createList(numberOfAccountsByStateMap, TEST_DummyInsertModeEnum.REAL); 
		Integer numberOfContactsPerAccount = 1;
		MOCK2_ContactFactory.createList(new Contact(), 1, TEST_DummyInsertModeEnum.REAL);
	} 
	
	@isTest static void testAccountsUpdateByQueueable(){
		// Arrange 
		Contact testContact = [SELECT Id, lastName FROM Contact LIMIT 1]; 
		TH_AccountAddContactQueueable updater = new TH_AccountAddContactQueueable(testContact, targetState);
		
		// Act 
        System.runAs(TestRunner){
            Test.startTest(); 
            {
            	System.enqueueJob(updater);
            }
            Test.stopTest();
        }

		// Assert
		List<Account> accountList = [SELECT id FROM Account WHERE BillingState = :targetState];
		Set<Id> accountIdSet = (new Map<Id,Account>(accountList)).keySet();
		Integer resultCount = [SELECT count() FROM Contact WHERE accountId IN :accountIdSet];
		System.assertEquals(numberOfAccountsInTarget, resultCount);
		
	}
}