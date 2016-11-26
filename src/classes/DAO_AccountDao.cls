public virtual class DAO_AccountDao { 
	public virtual UTIL_ResultListWrapper doInsert(Account account){
		return DAO_SObjectDMLHelper.doInsert(account);
	}  
}