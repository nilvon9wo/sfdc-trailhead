public class TH_ContactListVFController {
	private DAO_ContactDao contactDao;
	private String sortOrder = 'LastName';
	private Integer listSize = 10;
	
	public TH_ContactListVFController(DAO_ContactDao contactDao){
		this.contactDao = contactDao;
	}
	
	public TH_ContactListVFController(){
		this(new DAO_ContactDao());
	}
	
	public List<Contact> getContactList() {
	    return Database.query(
	        'SELECT Id, FirstName, LastName, Title, Email ' +
	        'FROM Contact ' +
	        'ORDER BY ' + sortOrder + ' ASC ' +
	        'LIMIT 10'
	    );
	}
	
	public void sortByLastName(){
		this.sortOrder = 'lastName';
	}

	public void sortByFirstName(){
		this.sortOrder = 'firstName';
	}
	     
}