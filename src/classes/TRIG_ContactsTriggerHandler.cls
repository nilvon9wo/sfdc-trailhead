public class TRIG_ContactsTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
		new Schema.SObjectType[]{ 
			Contact.SObjectType
		} 
	);
	List<Contact> contactList;
	TH_Contacts Contacts; 
	
	public TRIG_ContactsTriggerHandler(List<Contact> contactList, TH_Contacts Contacts) {
		super(contactList);
		this.contactList = contactList;
		this.Contacts = Contacts;
	}
 
	public TRIG_ContactsTriggerHandler(List<Contact> contactList) {
		this(contactList, new TH_Contacts(contactList, unitOfWork));
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> contactList) {
			return new TRIG_ContactsTriggerHandler (contactList);
		}
	}

    public override void onValidate() {
    	contacts.restrictContactByName(); 
    }
    
    public override void onValidate(Map<Id,SObject> existingAccountMap) {
    	contacts.restrictContactByName(); 
    }
}