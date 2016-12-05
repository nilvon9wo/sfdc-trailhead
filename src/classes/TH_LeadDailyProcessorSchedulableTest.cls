@isTest
private class TH_LeadDailyProcessorSchedulableTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final String CRON_EXPRESSION = '0 0 0 15 3 ? 2022'; // 2015 March 15  
	
	@isTest static void processorShouldSetSourceToDreamforce(){
		// Arrange
		TH_LeadDailyProcessorSchedulable processorUnderTest = new TH_LeadDailyProcessorSchedulable();

		Integer numberOfLeads = 200;
		List<Lead> leadList = MOCK2_LeadFactory.createList(new Lead(), numberOfLeads, TEST_DummyInsertModeEnum.REAL);
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                System.schedule('ScheduledApexTest', CRON_EXPRESSION, processorUnderTest); 
            }
            Test.stopTest();
        }

		// Assert
		Integer resultCount = [ SELECT count() FROM Lead WHERE id IN :leadList AND leadSource = :'Dreamforce' ];
		System.assertEquals(numberOfLeads, resultCount);
	}
}