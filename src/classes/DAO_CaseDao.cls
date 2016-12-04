public virtual class DAO_CaseDao {
    private DAO_CaseSelector selector; 

    public DAO_CaseDao(DAO_CaseSelector selector) {
        this.selector = selector;
    }

    public DAO_CaseDao() {
        this(new DAO_CaseSelector());
    }	
	
    public virtual UTIL_ResultListWrapper doInsert(List<Case> accountList) {
        return DAO_SObjectDMLHelper.doInsert(accountList);
    }
	
	public virtual UTIL_ResultListWrapper doUpdate(List<Case> caseList){
		return DAO_SObjectDMLHelper.doUpdate(caseList);
	}

	public virtual UTIL_ResultListWrapper doDelete(List<Case> caseList){
		return DAO_SObjectDMLHelper.doDelete(caseList);
	}
	
	public UTIL_ResultListWrapper doUpsert(List<Case> caseList, boolean allOrNone) {
		UTIL_ResultListWrapper resultWrapper = new UTIL_ResultListWrapper(Database.upsert(caseList, allOrNone));
    	return DAO_SObjectDMLHelper.postDmlProcess('Upsert', (List<SObject>) caseList, resultWrapper);
    }

	public UTIL_ResultListWrapper doUpsert(List<Case> sObjectList) { return doUpsert(sObjectList, 				 		false); }
	public UTIL_ResultListWrapper doUpsert(Case currentSObject) 	 { return doUpsert(new List<Case>{ currentSObject }, false); }

	public virtual List<Case> getByIds (Set<Id> idSet) {
		return this.selector.selectById(idSet);
	}  
}