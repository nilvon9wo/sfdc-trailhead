public virtual class DAO_OpportunitiesDao {
	public virtual List<Opportunity> getByIds (Set<Id> idSet) {
		return [
			SELECT amount,
				(SELECT unitPrice FROM OpportunityLineItems)
			FROM Opportunity
			WHERE id IN :idSet
		];
	}
	
	public virtual void tryUpdate(List<List<SObject>> updatedRecordLists){
		SavePoint savePoint = Database.setSavePoint();
		try {
			for (List<SObject> updatedRecordList : updatedRecordLists){
				DAO_SObjectDMLHelper.doUpdate(updatedRecordList, DAO_SObjectDMLHelper.ALL_OR_NONE);
			}
		}
		catch (Exception e){
			Database.rollback(savePoint);
			throw e;
		}
	}    
}