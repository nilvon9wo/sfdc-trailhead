@isTest
private class AccountProcessorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final Boolean ATTACH_CONTACTS = TRUE;
	private static final Boolean NO_ATTACHED_CONTACTS = FALSE;
	
	@isTest static void testCountContactsShouldCorrectlySetNumberOfContacts(){
		// Arrange
		Integer testNumberOfContacts = 1;
		Account testAccount = createTestAccounts(1, ATTACH_CONTACTS)[0];
		Id testAccountId = testAccount.id;
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
             	AccountProcessor.countContacts(new List<Id>{testAccountId});
            }
            Test.stopTest();
        }

		// Assert
		List<Account> resultAccountList = [SELECT number_of_contacts__c FROM Account WHERE id = :testAccountId];
		System.assertEquals(testNumberOfContacts, resultAccountList[0].number_of_contacts__c);
	}

	// ------------------------------------------------------------------------------------------

	@isTest static void testUpdateCountContactsShouldCorrectlyUpdateNumberOfContacts(){
		// Arrange
		AccountProcessor processorUnderTest = new AccountProcessor();
		Integer testNumberOfContacts = 1;
		Account testAccount = createTestAccounts(1, ATTACH_CONTACTS)[0];
		Id testAccountId = testAccount.id;
		 
		// Act
		List<Account> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
             	resultList = processorUnderTest.updateContactCount(new List<Id>{testAccountId});
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(testNumberOfContacts, resultList[0].number_of_contacts__c);
		List<Account> resultAccountList = [SELECT number_of_contacts__c FROM Account WHERE id = :testAccountId];
		System.assertEquals(testNumberOfContacts, resultAccountList[0].number_of_contacts__c);
	}

	// ------------------------------------------------------------------------------------------

	@isTest static void testSetCountContactsShouldCorrectlySetNumberOfContacts(){
		// Arrange
		AccountProcessor processorUnderTest = new AccountProcessor();
		Integer testNumberOfContacts = 1;
		List<Account> testAccountList = createTestAccounts(1, ATTACH_CONTACTS);
		
		// Act
		List<Account> resultList;
        System.runAs(TestRunner){
            Test.startTest();
            {
             	resultList = processorUnderTest.setContactCount(testAccountList);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(testNumberOfContacts, resultList[0].number_of_contacts__c);
	}

	// ------------------------------------------------------------------------------------------
		
	private static List<Account> createTestAccounts(Integer testNumberOfContacts, Boolean attachContacts) {
		Map<SObjectType, List<SObject>> createdObjectMap = MOCK_AccountFactory.createWithContactList(
			1, 
			testNumberOfContacts, 
			TEST_DummyInsertModeEnum.REAL
		);
		List<Account> accountList = (List<Account>) createdObjectMap.get(Account.getSObjectType());
		return (attachContacts) 
			? [ SELECT id, number_of_contacts__c, (SELECT id FROM Contacts) 
					FROM Account 
					WHERE id IN :accountList 
				]
			: accountList;
	}

	private static List<Account> createTestAccounts(Integer testNumberOfContacts) {
		return createTestAccounts(testNumberOfContacts, false);
	}


}
