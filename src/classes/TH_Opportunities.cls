public class TH_Opportunities {
	List<Opportunity> opportunityList;
	Map<Id, Decimal> discountPercentageByOpportunityId;
	
	public TH_Opportunities(List<Opportunity> opportunityList, Map<Id, Decimal> discountPercentageByOpportunityId){
		this.opportunityList = opportunityList;
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
	}
	
	public fflib_SObjectUnitOfWork applyDiscounts(fflib_SObjectUnitOfWork unitOfWork, List<Decimal> discountList){
		
		for(Opportunity opportunity: this.opportunityList) {
			Decimal discountPercentage = this.discountPercentageByOpportunityId.get(opportunity.id);
			Decimal factor = 1 - (discountPercentage == null ? 0 : discountPercentage / 100);
			
			TH_OpportunitiesLineItemDiscountStrategy discountStrategy = 
				new TH_OpportunitiesLineItemDiscountStrategy(unitOfWork, opportunity, factor, discountList);
					
			discountStrategy.execute(opportunity.opportunityLineItems);
		}
		
		return unitOfWork;  
	}
}