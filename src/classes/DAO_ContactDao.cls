public virtual class DAO_ContactDao {
	public virtual UTIL_ResultListWrapper doInsert(List<Contact> contactList){
		return DAO_SObjectDMLHelper.doInsert(contactList);
	}  

	public virtual UTIL_ResultListWrapper doUpdate(List<Contact> contactList){
		return DAO_SObjectDMLHelper.doUpdate(contactList);
	}  

	public virtual UTIL_ResultListWrapper doDelete(List<Contact> contactList) {
		return DAO_SObjectDMLHelper.doDelete(contactList);
	}
	
	public virtual List<Contact> getByLastName(String lastName) {
		return [SELECT id FROM Contact WHERE lastName =: lastName];
	}  
}