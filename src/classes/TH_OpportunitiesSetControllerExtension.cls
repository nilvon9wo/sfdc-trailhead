public class TH_OpportunitiesSetControllerExtension { 
	private ApexPages.StandardSetController standardSetController;
	private TH_OpportunitiesDiscountService opportunitiesService;
	
	TH_OpportunitiesSetControllerExtension(ApexPages.StandardSetController standardSetController, TH_OpportunitiesDiscountService opportunitiesService){
		this.standardSetController = standardSetController;
		this.opportunitiesService = opportunitiesService;
	} 
	
	TH_OpportunitiesSetControllerExtension(ApexPages.StandardSetController standardSetController){ 
		this(standardSetController, new TH_OpportunitiesDiscountService());
	}

	public Decimal discountPercentage {get; private set;}    
	 
	public PageReference applyDiscounts() {
		try {
			Set<Id> opportunityIdSet = new Map<Id, SObject>(this.standardSetController.getSelected()).keySet();
			opportunitiesService.applyDiscounts(opportunityIdSet, discountPercentage); 
		} 
		catch (Exception e) {
			ApexPages.addMessages(e);
		}
		
		return ApexPages.hasMessages() ? null : standardSetController.cancel();
	}
}