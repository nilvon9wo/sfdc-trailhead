global class TH_OpportunitiesDiscountService {  
 
	global static List<Decimal> getDiscounts(List<TH_OpportunityDiscountInfo> opportunityDiscountInfoList) {
		TH_OpportunitiesDiscountService service = new TH_OpportunitiesDiscountService();
		return service.applyDiscounts(opportunityDiscountInfoList);
	}

	public static List<Decimal> getDiscounts(List<Id> opportunityIdList, Decimal discountPercentage, TH_OpportunitiesDiscountServiceOptions config ) {
		TH_OpportunitiesDiscountService service = new TH_OpportunitiesDiscountService();
		return service.applyDiscounts(opportunityIdList, discountPercentage, config);
	}

	public List<Decimal> applyDiscounts(Map<Id, Decimal> discountPercentageByOpportunityId, TH_OpportunitiesDiscountServiceOptions options) {
		List<Decimal> discountList = new List<Decimal>();
  
		TH_OpportunitiesDiscountStrategy discountStrategy =  
			new TH_OpportunitiesDiscountStrategy(discountPercentageByOpportunityId, discountList, options.commitWork); 

		discountStrategy.execute(discountPercentageByOpportunityId.values());
		return discountList;
	}
 
	public List<Decimal> applyDiscounts(List<Id> opportunityIdList, Decimal discountPercentage, TH_OpportunitiesDiscountServiceOptions config) {
		Map<Id, Decimal> discountPercentageByOpportunityId = TH_Opportunities.getDefaultDiscountMap(opportunityIdList);
		return this.applyDiscounts(discountPercentageByOpportunityId, new TH_OpportunitiesDiscountServiceOptions()); 
	}
	
	public List<Decimal> applyDiscounts(List<TH_OpportunityDiscountInfo> opportunityDiscountInfoList) {
		Map<Id, Decimal> discountPercentageByOpportunityId = new Map<Id, Decimal>(); 
		for (TH_OpportunityDiscountInfo discountInfo : opportunityDiscountInfoList) {
			discountPercentageByOpportunityId.put(discountInfo.opportunityId, discountInfo.discountPercentage);	 
		}
		return this.applyDiscounts(discountPercentageByOpportunityId, new TH_OpportunitiesDiscountServiceOptions());
	}

	public List<Decimal> applyDiscounts(List<Id> opportunityIdList, Decimal discountPercentage) { 
		return this.applyDiscounts(opportunityIdList, discountPercentage, new TH_OpportunitiesDiscountServiceOptions());	
	}  

	public List<Decimal> applyDiscounts(Set<Id> opportunityIdSet, Decimal discountPercentage) { 
		return this.applyDiscounts(new List<Id>(opportunityIdSet), discountPercentage);	
	}  

	public List<Decimal> applyDiscounts(Id opportunityId, Decimal discountPercentage) {
		return  this.applyDiscounts(new List<Id>{opportunityId}, discountPercentage);
	}
}