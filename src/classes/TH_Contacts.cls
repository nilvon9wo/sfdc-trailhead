public class TH_Contacts {
	private fflib_SObjectUnitOfWork unitOfWork;
	private List<Contact> contactList;
	private DAO_contactDao contactDao;
	private TH_EmailManager emailManager;
 
	public TH_Contacts(
						List<Contact> ContactList, 
						fflib_SObjectUnitOfWork unitOfWork, 
						DAO_contactDao contactDao,
						TH_EmailManager emailManager
					) {
		this.contactList = contactList;
		this.unitOfWork = unitOfWork;
		this.contactDao = contactDao;
		this.emailManager = emailManager;
	}

	public TH_Contacts(List<Contact> ContactList, fflib_SObjectUnitOfWork unitOfWork) {
		this(ContactList, unitOfWork, new DAO_contactDao(), new TH_EmailManager());
	}

	// ---------------------------------------------------------------------------------------

	public TH_Contacts sendMail(){
		for (Contact contact : this.contactList) {
			emailManager.sendMail(new TH_Email(
				'Trailhead Trigger Tutorial', 
				'your-email-address@example.com',
				this.contactList.size() + ' contact(s) were inserted.'
			));
		}
		return this;
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