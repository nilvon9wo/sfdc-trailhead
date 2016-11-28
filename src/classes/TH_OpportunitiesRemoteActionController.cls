public class TH_OpportunitiesRemoteActionController {
	private TH_OpportunitiesDiscountService opportunitiesService;
	
	TH_OpportunitiesRemoteActionController(TH_OpportunitiesDiscountService opportunitiesService){
		this.opportunitiesService = opportunitiesService;
	} 
	
	TH_OpportunitiesRemoteActionController(){ 
		this(new TH_OpportunitiesDiscountService());
	}

	@RemoteAction
	public static void applyDiscount(Id opportunityId, Decimal discountPercent) {
		TH_OpportunitiesRemoteActionController controller = new TH_OpportunitiesRemoteActionController();
		controller.discount(opportunityId, discountPercent);			
	}
	
	private void discount(Id opportunityId, Decimal discountPercent) {
		this.opportunitiesService.applyDiscounts(opportunityId, discountPercent); 
	} 
}