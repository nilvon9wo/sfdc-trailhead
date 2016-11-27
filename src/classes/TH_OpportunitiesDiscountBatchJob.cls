public with sharing class TH_OpportunitiesDiscountBatchJob implements Database.Batchable<SObject> {
	public Decimal discountPercentage {get; private set;}    
	private TH_OpportunitiesService opportunitiesService;
	
	public TH_OpportunitiesDiscountBatchJob(Decimal discountPercentage, TH_OpportunitiesService opportunitiesService){
		this.discountPercentage = discountPercentage;
		this.opportunitiesService = opportunitiesService;
	} 
	
	public TH_OpportunitiesDiscountBatchJob(Decimal discountPercentage) {
		this(discountPercentage, new TH_OpportunitiesService());
	}
	
	public Database.QueryLocator start(Database.BatchableContext context) {
		return Database.getQueryLocator(
			'SELECT id FROM Opportunity WHERE stageName = \'Negotiation/Review\''
		);
	}
	
	public void execute(Database.BatchableContext context, List<SObject> scope) {
		try {
			Set<Id> opportunityIdSet = new Map<Id, SObject>(scope).keySet();
			opportunitiesService.applyDiscounts(opportunityIdSet, discountPercentage); 
			
		} 
		catch (Exception e) {
			// TODO: Email error, log error, chatter error, etc.... 
		}
	}
	
	public void finish(Database.BatchableContext context) {}
}