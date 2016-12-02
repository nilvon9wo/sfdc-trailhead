public virtual class DAO_ContactDao {
	DAO_AccountDao accountDao;
	
	public DAO_ContactDao(DAO_AccountDao accountDao){
		this.accountDao = accountDao;
	}

	public DAO_ContactDao(){
		this(new DAO_AccountDao());
	}
	
	public virtual UTIL_ResultListWrapper doInsert(List<Contact> contactList){
		return DAO_SObjectDMLHelper.doInsert(contactList);
	}  

	public virtual UTIL_ResultListWrapper doUpdate(List<Contact> contactList){
		return DAO_SObjectDMLHelper.doUpdate(contactList);
	}  

	public virtual UTIL_ResultListWrapper doDelete(List<Contact> contactList) {
		return DAO_SObjectDMLHelper.doDelete(contactList);
	}
	
	public UTIL_ResultListWrapper deleteByLastName(String lastName) {
		List<Contact> contactList = this.getByLastName(lastName);
		return this.doDelete(contactList); 
	}

	public virtual List<Contact> getByLastName(String lastName) {
		return [SELECT id FROM Contact WHERE lastName =: lastName];
	}
	
	public virtual List<Contact> getByFirstNameAndLastName(TH_PersonName name) { 
		return [
			SELECT account.name 
			FROM Contact 
			WHERE firstName =: name.firstName
				AND lastName =: name.lastName
		];
	}  

	public List<Contact> getByLastNameAndPostalCode(String lastName, String postalCode) {
		return [
			SELECT id, name 
			FROM Contact 
			WHERE lastName =: lastName
				AND mailingPostalCode =: postalCode
		]; 
	}
	
	public virtual List<Contact> getByDepartment(String targetDepartment) {
		return [SELECT firstName, lastName FROM Contact WHERE department =: targetDepartment];
	}

	public List<List<Contact>> getFromAccountsByAccountName(String accountName) {
		List<Account> accountList = accountDao.getWithContactByAccountName(accountName);
		List<List<Contact>> contactListList = new List<List<Contact>>();
		for (Account account: accountList){
			contactListList.add(account.Contacts);
		}
		return contactListList;
	}
	
	public virtual Map<SObjectType, UTIL_ResultListWrapper> updateWithAccount(Contact contact) {
		UTIL_ResultListWrapper contactResult = DAO_SObjectDMLHelper.doUpdate(contact);
		UTIL_ResultListWrapper accountResult = DAO_SObjectDMLHelper.doUpdate(contact.account);
		
		return new Map<SObjectType, UTIL_ResultListWrapper>{
			Contact.getSObjectType() => contactResult,
			Account.getSObjectType() => accountResult
		};
	}
}