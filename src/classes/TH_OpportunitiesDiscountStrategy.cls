public class TH_OpportunitiesDiscountStrategy extends UTIL_IfPopulatedListStrategy {  
	DAO_OpportunitiesDao opportunitiesDao;
	Boolean updateRecords;
	Map<Id, Decimal> discountPercentageByOpportunityId;
	List<Decimal> discountList; 

	public TH_OpportunitiesDiscountStrategy(
			Map<Id, Decimal> discountPercentageByOpportunityId,
			Boolean updateRecords, 
			List<Decimal> discountList,
			DAO_OpportunitiesDao opportunitiesDao
		){
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
		this.updateRecords = updateRecords;
		this.opportunitiesDao = opportunitiesDao;
		this.discountList = discountList;
	}

	public TH_OpportunitiesDiscountStrategy(
			Map<Id, Decimal> discountPercentageByOpportunityId, 
			Boolean updateRecords, 
			List<Decimal> discountList
		){
		this(discountPercentageByOpportunityId, updateRecords, discountList, new DAO_OpportunitiesDao());
	}
	
	public void doIfPopulated(List<Object> opportunityIdList){
		Set<Id> opportunityIdSet = new Set<Id>((List<Id>) opportunityIdList);
		
		for (Id opportunityId : (List<Id>) opportunityIdList) {
			Decimal discountPercentage = discountPercentageByOpportunityId.get(opportunityId);
			if (discountPercentage < 0 || discountPercentage > 100) {
				throw new TH_OpportunitiesServiceException(
					'Invalid discount of ' + discountPercentage + 'to apply to Opportunity ' + opportunityId + '.'
				);
			}
		}
		
		List<Opportunity> opportunityList = opportunitiesDao.getByIds(opportunityIdSet);
		List<List<SObject>> updatedRecordLists = getDiscountedRecords(opportunityList);

		if (this.updateRecords){
			opportunitiesDao.tryUpdate(updatedRecordLists);
		}
	}
	
	private List<List<SObject>> getDiscountedRecords(List<Opportunity> opportunityList){
		List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
		List<OpportunityLineItem> opportunityLineItemsToUpdateList = new List<OpportunityLineItem>();
		
		for(Opportunity opportunity: opportunityList) {
			Decimal discountPercentage = discountPercentageByOpportunityId.get(opportunity.id);
			Decimal factor = 1 - (discountPercentage == null ? 0 : discountPercentage / 100);
			
			TH_OpportunitiesLineItemDiscountStrategy discountStrategy = 
				new TH_OpportunitiesLineItemDiscountStrategy(
					opportunitiesToUpdate, opportunityLineItemsToUpdateList, opportunity, factor, this.discountList
				);	
			discountStrategy.execute(opportunity.opportunityLineItems);
		}
		
		return new List<List<SObject>> { opportunityLineItemsToUpdateList, opportunitiesToUpdate }; 
	}
	
	public void doIfEmpty(){
		throw new TH_OpportunitiesServiceException('Opportunities not specified.');
	}
}