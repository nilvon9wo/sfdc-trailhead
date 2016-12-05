global class TH_OpportunityOwnerReminderSchedulable implements Schedulable {
	DAO_OpportunitiesDao opportunitiesDao;
	TH_TaskUtil taskUtil;
	
	private static final Boolean IS_OPEN = FALSE;
	
	TH_OpportunityOwnerReminderSchedulable(DAO_OpportunitiesDao opportunitiesDao, TH_TaskUtil taskUtil){
		this.opportunitiesDao = opportunitiesDao;
		this.taskUtil = taskUtil;
	}

	TH_OpportunityOwnerReminderSchedulable(){
		this(new DAO_OpportunitiesDao(), new TH_TaskUtil());
	}
	
	global void execute (SchedulableContext context){
		List<Opportunity> opportunityList = opportunitiesDao.getOverdue();
		taskUtil.remindOwners(opportunityList); 
	}
	
	public Id schedule(String cronExpression) {
		return System.schedule('Remind Opportunity Owners', cronExpression, new TH_OpportunityOwnerReminderSchedulable());
	}
}