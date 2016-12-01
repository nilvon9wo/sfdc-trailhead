@isTest
private class TRIG_AccountTriggerTest {
    private static final User TestRunner = TEST_RunAsUserFactory.create();
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Account.SObjectType
		} 
	);

    private static testMethod void shouldCreateNewAccountsInBulk() {
        // Arrange
        Integer quantity = 200;
        List<Account> accountList = MOCK_AccountFactory.createList(unitOfWork, quantity);

        // Act
        System.runAs(TestRunner) {
            Test.startTest();
            {
            	unitOfWork.commitWork();
            }
            Test.stopTest();
        }

        // Assert
        List<Account> verifyAccountList = [SELECT Id FROM Account];
        System.assertEquals(quantity, verifyAccountList.size());
        
        List<Opportunity> verifyOpportunityList = [SELECT Id FROM Opportunity];
        System.assertEquals(quantity, verifyOpportunityList.size());
    }
    
    private static testMethod void shouldSetAllShippingStatesToBillingStates() {
        // Arrange
        Integer quantity = 200;
        List<Account> accountList = MOCK_AccountFactory.createList(unitOfWork, quantity);

        // Act
        System.runAs(TestRunner) {
            Test.startTest();
            {
            	unitOfWork.commitWork();
            }
            Test.stopTest();
        }

        // Assert
        for (Account account: [SELECT shippingState FROM Account]) {
	        System.assertEquals(account.shippingState, MOCK_AccountFactory.defaultBillingState);
        }
    }
}