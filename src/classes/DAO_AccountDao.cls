public virtual class DAO_AccountDao {
    private DAO_AccountsSelector selector;
    
    private static final Integer USE_SFDC_LIMIT = -999;

    public DAO_AccountDao(DAO_AccountsSelector selector) {
        this.selector = selector;
    }

    public DAO_AccountDao() {
        this(new DAO_AccountsSelector());
    }

    public virtual UTIL_ResultListWrapper doInsert(List<Account> accountList) {
        return DAO_SObjectDMLHelper.doInsert(accountList);
    }

    public virtual UTIL_ResultListWrapper doInsert(Account account) {
        return DAO_SObjectDMLHelper.doInsert(account);
    }

    public virtual UTIL_ResultListWrapper doUpdate(List<Account> accountList) {
        return DAO_SObjectDMLHelper.doUpdate(accountList);
    }

    public virtual UTIL_ResultListWrapper doUpdate(Account account) {
        return DAO_SObjectDMLHelper.doUpdate(account);
    }

    public virtual UTIL_ResultListWrapper doDelete(List<Account> accountList) {
        return DAO_SObjectDMLHelper.doDelete(accountList);
    }

    public virtual UTIL_ResultListWrapper deleteByName(String name) {
        List<Account> accountList = this.getByName(name);
        return this.doDelete(accountList);
    }
 
    public virtual List<Account> getAllsNamesAndPhones() {
        return this.selector.selectAllAccountList();
    }

    public virtual List<Account> getByName(String name) {
        return this.selector.selectByExactName(name);
    }

    public virtual List<Account> getWithContactsByAccountIds(Set<Id> idSet) {
        return this.selector.selectWithContactsByAccountIds(idSet); 
    }

    public virtual List<Account> getWithContactByAccountName(String name) {
        return this.selector.selectWithContactsByExactName(name);
    }

    public virtual List<Account> getByIds(List<Id> accountIdList) {
        return this.selector.selectById(accountIdList);
    }

    public virtual Map<Id, Account> getMapByIds(List<Id> accountIdList) {
        return new Map<Id, Account>(this.selector.selectById(accountIdList));
    }
    
    public virtual Database.QueryLocator getLocatorWithContactsByBillingCountry(String country) {
        return this.selector.selectLocatorWithContactsByBillingCountry(country);
    }
    
    public virtual List<Account> getWithOpportuntiesByAccountId(Set<Id> accountIdSet){
    	return this.selector.selectWithOpportuntiesByAccountId(accountIdSet);
    }

    public virtual List<Account> getWithOpportuntiesByAccountId(List<Account> accountList){
		Map<Id, Account> accountsByIdMap = new Map<Id, Account>(accountList);
    	return this.selector.selectWithOpportuntiesByAccountId(accountsByIdMap.keySet());
    }

    public virtual List<Account> getThoseWithoutOpportuntiesByAccountId(Set<Id> accountIdSet){
    	return this.selector.selectThoseWithoutOpportuntiesByAccountId(accountIdSet);
    }

	public virtual List<Account> getThoseWithoutOpportuntiesByAccountId(List<Account> accountList){
		Map<Id, Account> accountsByIdMap = new Map<Id, Account>(accountList);
    	return this.selector.selectThoseWithoutOpportuntiesByAccountId(accountsByIdMap.keySet());
    }

    public void consumeAccountArraysByNamesLike(TH_AccountArrayConsumerInterface consumer, String nameLikeness) {
        // TODO: Move this selection into the selector.
        for (Account[] accountArray : [SELECT id FROM Account WHERE name LIKE:nameLikeness]) {
            consumer.execute(accountArray);
        }
    }

	public List<Account> getByBillingState(String stateAbbreviation) {
		return this.selector.selectByBillingState(stateAbbreviation, USE_SFDC_LIMIT); 
	}

	public List<Account> getByBillingState(String stateAbbreviation, Integer maxRecords) {
		return this.selector.selectByBillingState(stateAbbreviation, maxRecords); 
	}

}