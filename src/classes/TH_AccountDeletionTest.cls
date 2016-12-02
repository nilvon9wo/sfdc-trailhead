@isTest
private class TH_AccountDeletionTest {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Account.SObjectType,
			Opportunity.SObjectType
		} 
	);
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void deletingAccountWithOneOpportunityShouldFail(){
		// Arrange
		Account account = MOCK_AccountFactory.create(unitOfWork, 'Test Account');
		Opportunity opportunity = MOCK_OpportunityFactory.createWithAccount(unitOfWork, account); 
		unitOfWork.commitWork();
		
		// Act
		Database.DeleteResult result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = Database.delete(account, false);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(!result.isSuccess());
		System.assert(result.getErrors().size() > 0); 
		System.assertEquals(TH_Accounts.CANNOT_DELETE_WITN_OPPORTUNITIES, result.getErrors()[0].getMessage());
	}
}