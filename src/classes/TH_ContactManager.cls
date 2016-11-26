public class TH_ContactManager {
	DAO_ContactDao contactDao; 
	
	public TH_ContactManager(DAO_ContactDao contactDao){
		this.contactDao = contactDao;
	}
	
	public TH_ContactManager(){
		this(new DAO_ContactDao());
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