public class TH_ContactsFutureWebCalloutQueueable implements Queueable {
	private List<Contact> contactList;
	
	public TH_ContactsFutureWebCalloutQueueable(List<Contact> contactList){
		this.contactList = contactList;
	}
	
    public void execute(QueueableContext queueableContext) {
		LOG_Logger logger = new LOG_Logger();

    	for (Contact contact : contactList) {
			String result = TH_ContactUtil.calloutMethod(contact);
			logger.info('TH_ContactsFutureWebCalloutService::calloutFor:' +result); 
    	}
    }
}