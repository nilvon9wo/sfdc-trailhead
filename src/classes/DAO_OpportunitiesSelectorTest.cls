@isTest
private class DAO_OpportunitiesSelectorTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
    
	private static testMethod void whenQueryOpportunitiesGetProducts() {
		// Arrange
		DAO_OpportunitiesSelector selectorUnderTest = new DAO_OpportunitiesSelector();
		Set<Id> testRecordSet = setupTestOpportunities();
		
		// Act
		List<Opportunity> resultList;
        System.runAs(TestRunner){ 
            Test.startTest();  
            {
				resultList = selectorUnderTest.selectById(testRecordSet);	 
            } 
            Test.stopTest();
        }

		// Assert
		System.assertEquals(10, resultList.size());
		System.assertEquals(5, resultList[0].opportunityLineItems.size());
	}
    
    // ------------------------------------------------------------
    
    private static Set<Id> setupTestOpportunities(){ 
    	Set<Id> opportunityIdSet = null;
    	List<Opportunity> mockOpprtunityList = MOCK_OpportunityFactory.createList(10, TEST_DummyInsertModeEnum.REAL)
    		.get(Opportunity.getSObjectType()); 
    	return new Map<Id, Opportunity>(mockOpprtunityList).keySet();
    }
}