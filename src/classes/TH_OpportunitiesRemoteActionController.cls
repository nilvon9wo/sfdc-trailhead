public class TH_OpportunitiesRemoteActionController {
	private TH_OpportunitiesService opportunitiesService;
	
	TH_OpportunitiesRemoteActionController(TH_OpportunitiesService opportunitiesService){
		this.opportunitiesService = opportunitiesService;
	} 
	
	TH_OpportunitiesRemoteActionController(){ 
		this(new TH_OpportunitiesService());
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