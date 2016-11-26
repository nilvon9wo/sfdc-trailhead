public class TH_ContactFactory {
	DAO_ContactDao contactDao; 
	
	public TH_ContactFactory(DAO_ContactDao contactDao){
		this.contactDao = contactDao;
	}
	
	public TH_ContactFactory(){
		this(new DAO_ContactDao());
	}
	
	public List<Contact> create(List<Contact> contactList, Boolean insertNow) {
		if (insertNow) {
			this.contactDao.doInsert(contactList);
		}
		return contactList;
	}
}