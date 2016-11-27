global class TH_OpportunitiesService {  
 
	global static List<Decimal> getDiscounts(List<TH_OpportunityDiscountInfo> opportunityDiscountInfoList) {
		TH_OpportunitiesService service = new TH_OpportunitiesService();
		return service.applyDiscounts(opportunityDiscountInfoList);
	}

	public static List<Decimal> getDiscounts(List<Id> opportunityIdList, Decimal discountPercentage, TH_OpportunitiesServiceOptions config ) {
		TH_OpportunitiesService service = new TH_OpportunitiesService();
		return service.applyDiscounts(opportunityIdList, discountPercentage, config);
	}

	public List<Decimal> applyDiscounts(Map<Id, Decimal> discountPercentageByOpportunityId, TH_OpportunitiesServiceOptions options) {
		List<Decimal> discountList = new List<Decimal>();
  
		TH_OpportunitiesDiscountStrategy discountStrategy =  
			new TH_OpportunitiesDiscountStrategy(discountPercentageByOpportunityId, discountList, options.commitWork); 

		discountStrategy.execute(discountPercentageByOpportunityId.values());
		return discountList;
	}

	public List<Decimal> applyDiscounts(List<Id> opportunityIdList, Decimal discountPercentage, TH_OpportunitiesServiceOptions config) {
		Map<Id, Decimal> discountPercentageByOpportunityId = new Map<Id, Decimal>();
		for (Id id : opportunityIdList) {
			discountPercentageByOpportunityId.put(id, discountPercentage);	 
		}
		return this.applyDiscounts(discountPercentageByOpportunityId, new TH_OpportunitiesServiceOptions());
	}
	
	public List<Decimal> applyDiscounts(List<TH_OpportunityDiscountInfo> opportunityDiscountInfoList) {
		Map<Id, Decimal> discountPercentageByOpportunityId = new Map<Id, Decimal>(); 
		for (TH_OpportunityDiscountInfo discountInfo : opportunityDiscountInfoList) {
			discountPercentageByOpportunityId.put(discountInfo.opportunityId, discountInfo.discountPercentage);	 
		}
		return this.applyDiscounts(discountPercentageByOpportunityId, new TH_OpportunitiesServiceOptions());
	}

	public List<Decimal> applyDiscounts(List<Id> opportunityIdList, Decimal discountPercentage) { 
		return this.applyDiscounts(opportunityIdList, discountPercentage, new TH_OpportunitiesServiceOptions());	
	}  

	public List<Decimal> applyDiscounts(Set<Id> opportunityIdSet, Decimal discountPercentage) { 
		return this.applyDiscounts(new List<Id>(opportunityIdSet), discountPercentage);	
	}  

	public List<Decimal> applyDiscounts(Id opportunityId, Decimal discountPercentage) {
		return  this.applyDiscounts(new List<Id>{opportunityId}, discountPercentage);
	}
}