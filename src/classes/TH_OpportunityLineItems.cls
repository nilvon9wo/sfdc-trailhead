public class TH_OpportunityLineItems extends fflib_SObjectDomain {
	List<OpportunityLineItem> opportunityLineItemList;
	
	public TH_OpportunityLineItems(List<OpportunityLineItem> opportunityLineItemList) {
		super(opportunityLineItemList);
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> opportunityLineItemList) {
			return new TH_OpportunityLineItems (opportunityLineItemList);
		}
	} 
	
	public void applyDiscount(Decimal discountFactor, List<Decimal> discountList, fflib_SObjectUnitOfWork unitOfWork) {
		for (OpportunityLineItem opportunityLineItem : (List<OpportunityLineItem>) Records) {
			opportunityLineItem.unitPrice = opportunityLineItem.unitPrice * discountFactor;
			discountList.add(opportunityLineItem.unitPrice);
			unitOfWork.registerDirty(opportunityLineItem);
		}
	}
}