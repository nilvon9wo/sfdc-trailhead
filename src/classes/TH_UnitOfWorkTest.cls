@isTest
private class TH_UnitOfWorkTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static testMethod void challangeComplete(){
		// Arrange
		fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {
		        Account.SObjectType,
		        Contact.SObjectType,
		        Note.SObjectType
		    });
		
		Integer requiredAccountQuantity = 100;
		Integer requiredContactQuantity = 500;
		Integer requiredNoteQuantity = 500;

		MOCK_AccountFactory.createList(unitOfWork, requiredAccountQuantity);
		List<Contact> contactList = MOCK_ContactFactory.createList(unitOfWork, requiredContactQuantity);
		MOCK_NoteFactory.createList(unitOfWork, contactList);
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
            	unitOfWork.commitWork(); 
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(100, [Select Id from Account].size());
		System.assertEquals(500, [Select Id from Contact].size());
		System.assertEquals(500, [Select Id from Note].size());
	}
}