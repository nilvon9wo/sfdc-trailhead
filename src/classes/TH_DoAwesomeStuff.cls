global class TH_DoAwesomeStuff implements Schedulable {
	DAO_CronTriggerSelector cronTriggerSelector;
	
	public TH_DoAwesomeStuff(DAO_CronTriggerSelector cronTriggerSelector){
		this.cronTriggerSelector = cronTriggerSelector;
	}
	
	public TH_DoAwesomeStuff(){
		this (new DAO_CronTriggerSelector());
	}
 
    global void execute(SchedulableContext context) {
    	Id triggerId = context.getTriggerId();
		CronTrigger cronTrigger = cronTriggerSelector.selectById(new Set<Id>{triggerId})[0];        
    }
}