@isTest
private class TH_OpportunityOwnerReminderSchedulabTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create();
	private static final String CRON_EXPRESSION = '0 0 0 15 3 ? 2022'; // 2015 March 15  
	
	@isTest static void schedulableShouldInsertTasks(){
		// Arrange
		Integer numberOfOpportunties = 10;
		Opportunity template = new Opportunity(closeDate = Date.today().addDays(-7));
		Set<Id> opportunityIdSet = new Map<Id, Opportunity>(
				MOCK2_OpportunityFactory.createList(template,numberOfOpportunties,TEST_DummyInsertModeEnum.REAL)
			).keySet();
		
		// Act
        System.runAs(TestRunner){
            Test.startTest(); 
            {
            	String jobId = System.schedule('ScheduledApexTest', CRON_EXPRESSION, new TH_OpportunityOwnerReminderSchedulable());
            	List<Task> immediateTaskList = queryTasks(opportunityIdSet);
            	System.assertEquals(0, immediateTaskList.size());
            }
            Test.stopTest();
        }

		// Assert
		List<Task> resultTaskLis = queryTasks(opportunityIdSet);
       	System.assertEquals(numberOfOpportunties, resultTaskLis.size());
	}
	
	private static List<Task> queryTasks(Set<Id> opportunityIdSet){
		return [SELECT id FROM Task WHERE whatId IN :opportunityIdSet];
	}
}