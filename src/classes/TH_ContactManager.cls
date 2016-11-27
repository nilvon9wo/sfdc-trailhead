public class TH_ContactManager {
	DAO_ContactDao contactDao;
	LOG_Logger logger; 
	
	public TH_ContactManager(DAO_ContactDao contactDao, LOG_Logger logger){
		this.contactDao = contactDao;
		this.logger = logger;
	}

	public TH_ContactManager(DAO_ContactDao contactDao){
		this(contactDao, new LOG_Logger());
	}
	
	public TH_ContactManager(){
		this(new DAO_ContactDao(), new LOG_Logger());
	}
	
	public Map<Boolean,List<Contact>> saveContactList(List<Contact> contactList){
		Map<Boolean, List<Contact>> savedContactsBySuccessMap = new Map<Boolean,List<Contact>>{
			true => new List<Contact>(),
			false => new List<Contact>()
		};
		
		UTIL_ResultListWrapper resultListWrapper = this.contactDao.doInsert(contactList);
		
		for(Integer i = 0; i < contactList.size(); i++) {  
			UTIL_ResultListWrapper.Result result = resultListWrapper.get(i);
			Contact contact = contactList[i];
			Boolean isSuccess = result.getIsSuccess();
			savedContactsBySuccessMap.get(isSuccess).add(contact);
			if (result.getIsSuccess()){
				logSuccess(contact);
			}
			else {
				logError(contact, result);
			}
		}
		
		return savedContactsBySuccessMap;
	}
	
	private void logSuccess(Contact contact) {
		String message = 'Successfully inserted contact, ' + contact.lastName + ', ' + contact.firstName + '; contact Id: ' + contact.id;
		logger.info(message);
	}
	
	private void logError(Contact contact, UTIL_ResultListWrapper.Result result) {
		String errorString = result.getErrorString();
		List<Database.Error> errorList = result.getErrorList();
		String message = 'The following error has occurred inserting contact, ' + contact.lastName + ', ' + contact.firstName + ', ' + contact.id + ': ' + errorString + '.\n' + 
			+ 'Contact fields that affected this error: ';
		for (Database.Error error: errorList) {
			message += error.getFields() + '\n';
		}		
		
		logger.error(message);
	}
	
	public List<Contact> assign(List<Contact> contactList, String qualifiedDepartment, String newTitle, Boolean updateNow) {
		List<Contact> updatedContactList = new List<Contact>(); 
		for (Contact contact : contactList){
			if (contact.department == qualifiedDepartment) {
				contact.title = newTitle;
				updatedContactList.add(contact);
			}
		}

		if (updateNow) {
			this.contactDao.doUpdate(updatedContactList);	
		}

		return updatedContactList;
	}  
}