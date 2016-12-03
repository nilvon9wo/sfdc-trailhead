public virtual class DAO_OpportunitiesDao {

	private DAO_OpportunitiesSelector selector;
	
	public  DAO_OpportunitiesDao(DAO_OpportunitiesSelector selector){
		this.selector = selector;
	}
 
	public DAO_OpportunitiesDao(){
		this(new DAO_OpportunitiesSelector());
	}

	public virtual UTIL_ResultListWrapper doInsert(List<Opportunity> opportunitiesList){
		return DAO_SObjectDMLHelper.doInsert(opportunitiesList);
	}
	
	public virtual List<Opportunity> getByIds (List<Id> idList) {
		return this.selector.selectById(idList); 
	} 

	public virtual List<Opportunity> getByAccountIds (Set<Id> accountIdSet) {
		return this.selector.selectByAccountIds(accountIdSet); 
	}

	public virtual List<Opportunity> getByAccountIds (List<Account> accountIdList) {
		Set<Id> accountIdSet = (new Map<Id, Account>(accountIdList)).keySet();
		return this.selector.selectByAccountIds(accountIdSet); 
	}
	
	public virtual void tryUpdate(fflib_SObjectUnitOfWork unitOfWork){
		unitOfWork.commitWork();	
	}	    
}