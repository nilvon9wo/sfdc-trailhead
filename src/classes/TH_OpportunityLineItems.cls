public class TH_OpportunityLineItems {
	List<OpportunityLineItem> opportunityLineItemList;
	
	public TH_OpportunityLineItems(List<OpportunityLineItem> opportunityLineItemList) {
		this.opportunityLineItemList = opportunityLineItemList;
	}
	
	public void applyDiscount(Decimal discountFactor, List<Decimal> discountList, fflib_SObjectUnitOfWork unitOfWork) {
		for (OpportunityLineItem opportunityLineItem : this.opportunityLineItemList) {
			opportunityLineItem.unitPrice = opportunityLineItem.unitPrice * discountFactor;
			discountList.add(opportunityLineItem.unitPrice);
			unitOfWork.registerDirty(opportunityLineItem);
		}
	}
}