public virtual class DAO_AccountDao {
	
	DAO_AccountsSelector selector;
	
	DAO_AccountDao(DAO_AccountsSelector selector){
		this.selector = selector;
	}

	DAO_AccountDao(){
		this(new DAO_AccountsSelector());
	}
	 
	public virtual UTIL_ResultListWrapper doInsert(List<Account> accountList){
		return DAO_SObjectDMLHelper.doInsert(accountList);
	}  

	public virtual UTIL_ResultListWrapper doInsert(Account account){
		return DAO_SObjectDMLHelper.doInsert(account);
	}  
	
	public virtual UTIL_ResultListWrapper doDelete(List<Account> accountList){
		return DAO_SObjectDMLHelper.doDelete(accountList);
	}

	public virtual UTIL_ResultListWrapper deleteByName (String name) {
		List<Account> accountList = this.getByName(name);
		return this.doDelete(accountList); 
	}

	public virtual List<Account> getByIds (List<Id> idList) { 
		return this.selector.selectById(idList);
	}

	public virtual Map<Id,Account> getMapByIds (List<Id> idList) {
		return new Map<Id,Account>(this.selector.selectById(idList));
	}

	public virtual List<Account> getAllsNamesAndPhones() {
		return this.selector.selectAllAccountList();
	}
	
	public virtual List<Account> getByName (String name) {
		return this.selector.selectByExactName(name);
	}

	public void consumeAccountArraysByNamesLike(TH_AccountArrayConsumerInterface consumer, String nameLikeness) {
		// TODO: Move this selection into the selector.
		for (Account[] accountArray : [ SELECT id FROM Account WHERE name LIKE: nameLikeness ]) {
			consumer.execute(accountArray);
		}
	}  
}