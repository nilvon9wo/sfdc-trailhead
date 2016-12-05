public class TH_LeadDailyProcessorSchedulable implements Schedulable {
	DAO_LeadDao leadDao;
	
	public TH_LeadDailyProcessorSchedulable(DAO_LeadDao leadDao){
		this.leadDao = leadDao;
	}
	
	public TH_LeadDailyProcessorSchedulable(){
		this(new DAO_LeadDao()); 
	}
	 
    public void execute(SchedulableContext context) {
        List<Lead> leadList = leadDao.getWithBlankSource(200);
        for (Lead lead : leadList) {
        	lead.leadSource = 'Dreamforce';
        }
        leadDao.doUpdate(leadList);
    }
}