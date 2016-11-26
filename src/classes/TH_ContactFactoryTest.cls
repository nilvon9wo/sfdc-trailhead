@isTest
private class TH_ContactFactoryTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static List<Contact> testContactList = new List<Contact>{
			MOCK_ContactFactory.createTestContact(),
			MOCK_ContactFactory.createTestContact(),
			MOCK_ContactFactory.createTestContact()
		};
	
	
	private static testMethod void createContactListShouldReturnListedContactsWithoutInsertingThemWhenDaoIsLater(){
		testCreate(DAO_Timing.LATER);
	}

	private static testMethod void createContactListShouldReturnListedContactsWithoutInsertingThemWhenDaoIsNow(){
		testCreate(DAO_Timing.NOW);
	}
	
	public static void testCreate(Boolean insertNow){
		// Arrange
		DAO_ContactDao mockContactDao = new Mock_ContactDao();
		TH_ContactFactory factoryUnderTest = new TH_ContactFactory(mockContactDao);
		
		// Act
		List<Contact> resultContactList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultContactList = factoryUnderTest.create(testContactList, insertNow);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(resultContactList, testContactList);
		for (Contact contact: resultContactList){
			if (insertNow){
				System.assertNotEquals(contact.id, null);
			}
			else {
				System.assertEquals(contact.id, null);
			} 
		}
	}
}