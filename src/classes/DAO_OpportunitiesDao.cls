public virtual class DAO_OpportunitiesDao {
	public virtual List<Opportunity> getByIds (Set<Id> idSet) {
		return [
			SELECT amount,
				(SELECT unitPrice FROM OpportunityLineItems)
			FROM Opportunity
			WHERE id IN :idSet
		];
	}
	
	public virtual void tryUpdate(fflib_SObjectUnitOfWork unitOfWork){
		unitOfWork.commitWork();	
	}	    
}