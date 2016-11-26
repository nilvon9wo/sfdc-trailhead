@isTest
private class TH_ContactManagerTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static final String targetLastName = 'Roth';
	private static final String targetDepartment = 'Finance';
	private static final String targetTitle = 'Finance analyst';
	
	private static List<Contact> testContactList = new List<Contact>{
		new Contact(firstName='Kathy', lastName='Smith', department='Technology'),
        new Contact(firstName='Caroline', lastName=targetLastName, department=targetDepartment),
        new Contact(firstName='Kim', lastName='Shain', department='Education') 
	};

	private static testMethod void assignShouldSetOnlyQualifiedContactsToNewTitle(){
		testAssign(DAO_Timing.LATER);		
	}

	private static testMethod void assignShouldSetQualifiedContactsToNewTitleAndSave(){
		Boolean previouslyInserted = true;
		testAssign(DAO_Timing.NOW);		
	}
	
	private static void testAssign(Boolean updateNow){
		// Arrange
		DAO_ContactDao mockContactDao = new MOCK_ContactDao();
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
		System.assertEquals(resultContactList.size(), 1);
		
		Contact result = resultContactList[0];
		System.assertEquals(result.lastName, targetLastName);
		System.assertEquals(result.department, targetDepartment);
		System.assertEquals(result.title, targetTitle);
	}
}