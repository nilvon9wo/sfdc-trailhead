public class TH_OpportunitiesLineItemDiscountStrategy extends UTIL_IfPopulatedListStrategy { 
	List<Opportunity> opportunitiesToUpdate; 
	List<OpportunityLineItem> opportunityLineItemsToUpdateList; 
	Opportunity opportunity;
	Decimal factor;
	List<Decimal> discountList; 
	
	public TH_OpportunitiesLineItemDiscountStrategy(
			List<Opportunity> opportunitiesToUpdate, 
			List<OpportunityLineItem> opportunityLineItemsToUpdateList, 
			Opportunity opportunity, 
			Decimal factor,
			List<Decimal> discountList 
		){
		this.opportunitiesToUpdate = opportunitiesToUpdate;
		this.opportunityLineItemsToUpdateList = opportunityLineItemsToUpdateList;
		this.opportunity = opportunity;
		this.factor = factor;
		this.discountList = discountList;
	}
	 
	public void doIfPopulated(List<Object> opportunityLineItemList){
		for (OpportunityLineItem opportunityLineItem : (List<OpportunityLineItem>) opportunityLineItemList) {
					opportunityLineItem.unitPrice = opportunityLineItem.unitPrice * this.factor;
					this.discountList.add(opportunityLineItem.unitPrice);
					this.opportunityLineItemsToUpdateList.add(opportunityLineItem);
				}	
		}	
		
	public void doIfEmpty(){
		this.opportunity.amount = opportunity.amount * factor;
		this.discountList.add(this.opportunity.amount);
		this.opportunitiesToUpdate.add(opportunity);
	}
}