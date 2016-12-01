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
	
	public virtual void tryUpdate(fflib_SObjectUnitOfWork unitOfWork){
		unitOfWork.commitWork();	
	}	    
}