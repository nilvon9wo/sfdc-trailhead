public class TH_OpportunitiesControllerExtension { 
	private ApexPages.StandardController standardController;
	private TH_OpportunitiesDiscountService opportunitiesService;
	
	TH_OpportunitiesControllerExtension(ApexPages.StandardController standardController, TH_OpportunitiesDiscountService opportunitiesService){
		this.standardController = standardController;
		this.opportunitiesService = opportunitiesService;
	} 

	TH_OpportunitiesControllerExtension(ApexPages.StandardController standardController){ 
		this(standardController, new TH_OpportunitiesDiscountService());
	}

	public Decimal discountPercentage {get; private set;}    
	
	public PageReference applyDiscount() {
		try {
			Set<Id> opportunityIdSet = new Set<Id> { standardController.getId() };
			opportunitiesService.applyDiscounts(opportunityIdSet, discountPercentage); 
		}
		catch (Exception e) {
			ApexPages.addMessages(e);
		}
		
		return ApexPages.hasMessages() ? null : standardController.view();
	}
}