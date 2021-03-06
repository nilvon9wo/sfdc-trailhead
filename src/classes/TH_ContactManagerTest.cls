@isTest
private class TH_ContactManagerTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static final String targetLastName = MOCK_ContactFactory.targetLastName;
	private static final String targetDepartment = MOCK_ContactFactory.targetDepartment;
	private static final String targetTitle = 'Finance analyst'; 

	private static final Boolean TARGET_NAME = true; 
	private static final Boolean NOT_TARGET_NAME = false; 

	private static final Boolean TARGET_DEPARTMENT = true; 
	private static final Boolean NOT_TARGET_DEPARTMENT = false; 

	private static Integer testContactCount = 0;

	private static testMethod void saveContactListShouldDivideSuccessfulFromUnsucessfulSaves(){
		// Arrange
		List<Contact> testContactList = new List<Contact>{
			MOCK_ContactFactory.create(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER),
			MOCK_ContactFactory.create(TARGET_NAME, TARGET_DEPARTMENT, DAO_Timing.LATER),
			MOCK_ContactFactory.create(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER),
			new Contact()
		};
		
		DAO_ContactDao mockContactDao = new MOCK_ContactDao();
		MOCK_ContactDao.insertedContactList = false;
		// TODO: Inject mock
		TH_ContactManager managerUnderTest = new TH_ContactManager();
		
		// Act
		Map<Boolean, List<Contact>> resultSavedContactsBySuccessMap;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultSavedContactsBySuccessMap = managerUnderTest.saveContactList(testContactList);
            }
            Test.stopTest();
        }

		// Assert
		// TODO: System.assert(MOCK_ContactDao.insertedContactList);
		System.assertEquals(resultSavedContactsBySuccessMap.get(true).size(), 3);
		System.assertEquals(resultSavedContactsBySuccessMap.get(false).size(), 1);
	}
	
	private static testMethod void assignShouldSetOnlyQualifiedContactsToNewTitle(){
		testAssign(DAO_Timing.LATER);		 
	}
 
	private static testMethod void assignShouldSetQualifiedContactsToNewTitleAndSave(){
		Boolean previouslyInserted = true; 
		testAssign(DAO_Timing.NOW);		
	}
	
	private static void testAssign(Boolean updateNow){
		// Arrange
		List<Contact> testContactList = new List<Contact>{
			MOCK_ContactFactory.create(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER),
			MOCK_ContactFactory.create(TARGET_NAME, TARGET_DEPARTMENT, DAO_Timing.LATER),
			MOCK_ContactFactory.create(NOT_TARGET_NAME, NOT_TARGET_DEPARTMENT, DAO_Timing.LATER)
		};

		DAO_ContactDao mockContactDao = new MOCK_ContactDao();
		MOCK_ContactDao.updatedContactList = false;
		mockContactDao.doInsert(testContactList); 
		TH_ContactManager managerUnderTest = new TH_ContactManager(mockContactDao); 
		
		// Act
		List<Contact> resultContactList;
        System.runAs(TestRunner){
            Test.startTest();
            {
                resultContactList = managerUnderTest.assign(testContactList, targetDepartment, targetTitle, updateNow);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(MOCK_ContactDao.updatedContactList, updateNow);
		
		System.assertEquals(resultContactList.size(), 1);
		
		Contact result = resultContactList[0];
		System.assertEquals(result.lastName, targetLastName);
		System.assertEquals(result.department, targetDepartment);
		System.assertEquals(result.title, targetTitle);
	}
}