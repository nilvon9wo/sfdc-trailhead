@isTest
private class TH_GenericSObjectWorkerTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static testMethod void setToAccountShouldSetSObjectToNamedAccout(){
		// Arrange
		TH_GenericSObjectWorker workerUnderTest = new TH_GenericSObjectWorker();
		String accountName = 'Trailhead';
		
		// Act
		Account result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = workerUnderTest.setToAccount(accountName);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result.name, accountName);
		
		Account fromGeneric = (Account) workerUnderTest.sObj;
		System.assertEquals(fromGeneric, result);
	}
	
	private static testMethod void setToBookShouldSetSObjectToNamedBook(){
		// Arrange
		TH_GenericSObjectWorker workerUnderTest = new TH_GenericSObjectWorker();
		String accountName = 'Workbook 1';
		
		// Act
		TH_Book__c result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = workerUnderTest.setToBook(accountName);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result.name, accountName);

		TH_Book__c fromGeneric = (TH_Book__c) workerUnderTest.sObj;
		System.assertEquals(fromGeneric, result);
	}
	
}