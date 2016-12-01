public class TH_OpportunitiesDefaultDiscounter {
	private Decimal defaultDiscount = 30;
	
	public static Map<Id, Decimal> getDefaultDiscountMap(List<Id> opportunityIdList){
		TH_OpportunitiesDefaultDiscounter discounter = new TH_OpportunitiesDefaultDiscounter();
		return discounter.createDefaultDiscountMap(opportunityIdList);
	}
	
	public static Map<Id, Decimal> getDefaultDiscountMap(List<Opportunity> opportunityList){
		List<Id> opportunityIdList = new List<Id>();
		for (Opportunity opportunity: opportunityList) {
			if (opportunity.id != null) {
				opportunityIdList.add(opportunity.id);
			}
		}
		return getDefaultDiscountMap(opportunityIdList);
	}
	
	private Map<Id, Decimal> createDefaultDiscountMap(List<Id> opportunityIdList) {
		Map<Id, Decimal> discountPercentageByOpportunityId = new Map<Id, Decimal>();
		for (Id id : opportunityIdList) {
			discountPercentageByOpportunityId.put(id, defaultDiscount);	 
		}
		return discountPercentageByOpportunityId;
	} 
}