public virtual class DAO_AccountDao { 
	public virtual UTIL_ResultListWrapper doInsert(List<Account> accountList){
		return DAO_SObjectDMLHelper.doInsert(accountList);
	}  

	public virtual UTIL_ResultListWrapper doInsert(Account account){
		return DAO_SObjectDMLHelper.doInsert(account);
	}  
	
	public virtual UTIL_ResultListWrapper doDelete(List<Account> accountList){
		return DAO_SObjectDMLHelper.doDelete(accountList);
	}

	public virtual List<Account> getAllsNamesAndPhones() {
		return [ SELECT name, phone FROM Account ];
	}
	
	public virtual List<Account> getByName (String name) {
		return [ SELECT id FROM Account WHERE name =: name ];
	}
	
	public virtual List<Account> getWithContactByAccountName (String accountName) {
		return [ 
			SELECT name,
				(SELECT firstName, lastName FROM Contacts) 
			FROM Account 
			WHERE name =: accountName 
		];
	}
	
	public virtual UTIL_ResultListWrapper deleteByName (String name) {
		List<Account> accountList = this.getByName(name);
		return this.doDelete(accountList);
	}
	
	public void consumeAccountArraysByNamesLike(TH_AccountArrayConsumerInterface consumer, String nameLikeness) {
		for (Account[] accountArray : [ SELECT id FROM Account WHERE name LIKE: nameLikeness ]) {
			consumer.execute(accountArray);
		}
	}  
}