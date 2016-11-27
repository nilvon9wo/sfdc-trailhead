@RestResource(urlMapping='/opportunity/*/apply-discount')
global with sharing class TH_OpportunitiesDiscountRestResource {
	TH_OpportunitiesService opportunitiesService;
	
	TH_OpportunitiesDiscountRestResource(TH_OpportunitiesService opportunitiesService){
		this.opportunitiesService = opportunitiesService;
	}
	
	TH_OpportunitiesDiscountRestResource(){
		this(new TH_OpportunitiesService());
	}
	
	@HttpPost
	global static void applyDiscount(Decimal discountPercentage) {
		TH_OpportunitiesDiscountRestResource resource = new TH_OpportunitiesDiscountRestResource();
		resource.discount(discountPercentage);
	}
	
	private void discount(Decimal discountPercentage) {
		RestRequest request = RestContext.request;
		String[] uriParts = request.requestURI.split('/');
		Id opportunityId = uriParts[2];
		
		opportunitiesService.applyDiscounts(
			new Set<Id>{ opportunityId }, discountPercentage
		);
	}	    
}