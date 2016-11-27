public class TH_OpportunitiesLineItemDiscountStrategy extends UTIL_IfPopulatedListStrategy { 
	fflib_SObjectUnitOfWork unitOfWork; 
	Opportunity opportunity;
	Decimal factor;
	List<Decimal> discountList; 
	
	public TH_OpportunitiesLineItemDiscountStrategy(
			fflib_SObjectUnitOfWork unitOfWork, 
			Opportunity opportunity, 
			Decimal factor,
			List<Decimal> discountList 
		){
		this.unitOfWork = unitOfWork;
		this.opportunity = opportunity;
		this.factor = factor;
		this.discountList = discountList;
	}
	 
	public void doIfPopulated(List<Object> opportunityLineItemList){
		for (OpportunityLineItem opportunityLineItem : (List<OpportunityLineItem>) opportunityLineItemList) {
					opportunityLineItem.unitPrice = opportunityLineItem.unitPrice * this.factor;
					this.discountList.add(opportunityLineItem.unitPrice);
					unitOfWork.registerDirty(opportunityLineItem);
				}	
		}	
		
	public void doIfEmpty(){
		this.opportunity.amount = opportunity.amount * factor;
		this.discountList.add(this.opportunity.amount);
		unitOfWork.registerDirty(opportunity);
	}
}