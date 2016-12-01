public class TH_ContactsFutureWebCalloutService {
	@future(callout=true)
	static void calloutFor(Set<Id> contactIdSet) {
		DAO_ContactSelector selector = new DAO_ContactSelector();
		List<Contact> contactList = selector.selectById(contactIdSet); 
		
		LOG_Logger logger = new LOG_Logger();
		for (Contact contact: contactList) {
			String result = TH_ContactUtil.calloutMethod(contact);
			logger.info('TH_ContactsFutureWebCalloutService::calloutFor:' +result); 
		}
	}
}