public class DAO_OpportunitiesSelector {

	public virtual List<Opportunity> selectById (List<Id> idList) {
		return [
			SELECT amount,
				(SELECT unitPrice FROM OpportunityLineItems)
			FROM Opportunity
			WHERE id IN :idList 
		]; 
	}

	public virtual List<Opportunity> selectById (Set<Id> idSet) {
		return this.selectById(new List<Id>(idSet)); 
	}

}