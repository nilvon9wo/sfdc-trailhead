public virtual class DAO_OpportunitiesDao {

	DAO_OpportunitiesSelector selector;
	
	DAO_OpportunitiesDao(DAO_OpportunitiesSelector selector){
		this.selector = selector;
	}
 
	DAO_OpportunitiesDao(){
		this(new DAO_OpportunitiesSelector());
	}
	
	public virtual List<Opportunity> getByIds (List<Id> idList) {
		return this.selector.selectById(idList); 
	}
	
	public virtual void tryUpdate(fflib_SObjectUnitOfWork unitOfWork){
		unitOfWork.commitWork();	
	}	    
}