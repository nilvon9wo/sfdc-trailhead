public class TH_AccountAddContactQueueable implements Queueable {
	private static final Integer MAX_ACCOUNTS = 200;

	private DAO_AccountDao accountDao;
	private DAO_ContactDao contactDao;
	
	Contact contact;
	String state;
	
	public TH_AccountAddContactQueueable (Contact contact, String state, DAO_AccountDao accountDao, DAO_ContactDao contactDao){
		this.contact = contact; 
		this.state = state;
    	this.accountDao = accountDao; 
    	this.contactDao = contactDao; 
	}
	 
	public TH_AccountAddContactQueueable (Contact contact, String state){
		this(contact, state, new DAO_AccountDao(), new DAO_ContactDao()); 
	}
	 
    public void execute(QueueableContext context) {
        List<Account> accountList = accountDao.getByBillingState(this.state, MAX_ACCOUNTS);
        List<Contact> newContactList = new List<Contact>(); 
        for (Account account : AccountList){
        	Contact newContact = this.contact.clone();
        	newContact.accountId = account.id;
        	newContactList.add(newContact);
        }
        UTIL_ResultListWrapper result = contactDao.doInsert(newContactList);
    }
}