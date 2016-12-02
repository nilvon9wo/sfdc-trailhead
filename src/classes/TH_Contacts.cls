public class TH_Contacts {
	private fflib_SObjectUnitOfWork unitOfWork;
	private List<Contact> contactList;
	private DAO_ContactDao ContactDao;
 
	public TH_Contacts(
						List<Contact> ContactList, 
						fflib_SObjectUnitOfWork unitOfWork, 
						DAO_ContactDao ContactDao
					) {
		this.contactList = contactList;
		this.unitOfWork = unitOfWork;
		this.ContactDao = ContactDao;
	}

	public TH_Contacts(List<Contact> ContactList, fflib_SObjectUnitOfWork unitOfWork) {
		this(ContactList, unitOfWork, new DAO_ContactDao());
	}
	
	// ---------------------------------------------------------------------------------------
	
	public TH_Contacts restrictContactByName() {
		for (Contact contact : this.contactList) {
			String lastName = contact.lastName; 
			if(lastName == 'INVALIDNAME') {	//invalidname is invalid
				contact.addError('The Last Name "'+lastName+'" is not allowed for DML');
			}
		}
		return this;
	}
}