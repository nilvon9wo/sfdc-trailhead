public class TH_Opportunities extends fflib_SObjectDomain {
	private static Decimal defaultDiscount = 30;

	List<Opportunity> opportunityList;
	Map<Id, Decimal> discountPercentageByOpportunityId;
	
	public TH_Opportunities(List<Opportunity> opportunityList, Map<Id, Decimal> discountPercentageByOpportunityId){
		super(opportunityList);
		this.opportunityList = opportunityList;
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
	}
	
	public TH_Opportunities(List<Opportunity> opportunityList) {
		this(opportunityList, getDefaultDiscountMap(opportunityList));
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> opportunityList) {
			return new TH_Opportunities (opportunityList);
		}
	}
	
	public static Map<Id, Decimal> getDefaultDiscountMap(List<Id> opportunityIdList){
		Map<Id, Decimal> discountPercentageByOpportunityId = new Map<Id, Decimal>();
		for (Id id : opportunityIdList) {
			discountPercentageByOpportunityId.put(id, defaultDiscount);	 
		}
		return discountPercentageByOpportunityId;
	}
	
	public static Map<Id, Decimal> getDefaultDiscountMap(List<Opportunity> opportunityList){
		List<Id> opportunityIdList = new List<Id>((new Map<Id, Opportunity>(opportunityList)).keySet());
		return getDefaultDiscountMap(opportunityIdList);
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