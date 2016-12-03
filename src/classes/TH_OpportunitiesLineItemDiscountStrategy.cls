public class TH_OpportunitiesLineItemDiscountStrategy extends UTIL_IfPopulatedListStrategy { 
	DAO_UnitOfWork unitOfWork; 
	Opportunity opportunity;
	Decimal discountFactor;
	List<Decimal> discountList; 
	
	public TH_OpportunitiesLineItemDiscountStrategy(
			DAO_UnitOfWork unitOfWork, 
			Opportunity opportunity, 
			Decimal discountFactor,
			List<Decimal> discountList 
		){
		this.unitOfWork = unitOfWork;
		this.opportunity = opportunity;
		this.discountFactor = discountFactor;
		this.discountList = discountList;
	}
	 
	public void doIfPopulated(List<Object> opportunityLineItemList){
		TH_OpportunityLineItems lineItems = new TH_OpportunityLineItems((List<OpportunityLineItem>) opportunityLineItemList);  
		lineItems.applyDiscount(this.discountFactor, this.discountList, unitOfWork);		 					 	
	}	
		
	public void doIfEmpty(){
		this.opportunity.amount = opportunity.amount * discountFactor;
		this.discountList.add(this.opportunity.amount);
		unitOfWork.register(opportunity);
	}
}