public class TH_TaskUtil {
	DAO_TaskDao taskDao;  
	
	public TH_TaskUtil(DAO_TaskDao taskDao){
		this.taskDao = taskDao;
	}

	public TH_TaskUtil(){
		this(new DAO_TaskDao());
	}
	
	public static String getTaskPriority(String leadState) {
		TH_TaskUtil util = new TH_TaskUtil();
		return util.getPriority(leadState);
	}
	
	@testVisible()
	private String getPriority(String leadState){
		if (String.isBlank(leadState) || leadState.length() > 2){
			return null;
		}
		
		return (leadState == 'CA') ? 'High' : 'Normal';
	}
	
	public void remindOwners(List<Opportunity> opportunityList) {
		List<Task> newTaskList = new List<Task>();
		for (Opportunity opportunity : opportunityList) {
			newTaskList.add(new Task(
				Description = 'Opportunity Reminder',
                Priority = 'Normal', 
                Status = 'Inbound Email', 
                Subject = 'The Calendar Days are Flying Away!', 
                IsReminderSet = true, 
                ReminderDateTime = System.now()+1, 
				whatId = opportunity.id				
			));				
		}
		UTIL_ResultListWrapper result = taskDao.doInsert(newTaskList);
	}
}