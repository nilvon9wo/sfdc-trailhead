public class TH_OpportunitiesDiscountStrategy extends UTIL_IfPopulatedListStrategy {  
	DAO_OpportunitiesDao opportunitiesDao;
	Boolean commitWork;
	Map<Id, Decimal> discountPercentageByOpportunityId; 
	List<Decimal> discountList; 

	public TH_OpportunitiesDiscountStrategy(
			Map<Id, Decimal> discountPercentageByOpportunityId,
			List<Decimal> discountList,
			DAO_OpportunitiesDao opportunitiesDao,
			Boolean commitWork
		){
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
		this.discountList = discountList;
		this.commitWork = commitWork;
		this.opportunitiesDao = opportunitiesDao;
	}

	public TH_OpportunitiesDiscountStrategy(
			Map<Id, Decimal> discountPercentageByOpportunityId, 
			List<Decimal> discountList,
			Boolean commitWork
		){
		this(discountPercentageByOpportunityId, discountList, new DAO_OpportunitiesDao(), commitWork);
	}
	
	public void doIfPopulated(List<Object> opportunityIdList){
		Set<Id> opportunityIdSet = new Set<Id>((List<Id>) opportunityIdList);
		
		fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork(
			new List<SObjectType> {OpportunityLineItem.SObjectType, Opportunity.SObjectType}
		);
		
		if (validDiscounts((List<Id>) opportunityIdList)) {
			TH_Opportunities opportunities = new TH_Opportunities(
				opportunitiesDao.getByIds(opportunityIdSet), 
				this.discountPercentageByOpportunityId
			);
			opportunities.applyDiscounts(unitOfWork, this.discountList);
	
			if (this.commitWork){
				opportunitiesDao.tryUpdate(unitOfWork); 
			}
		}
	}
	
	private Boolean validDiscounts(List<Id> opportunityIdList){
		for (Id opportunityId : opportunityIdList) {
			Decimal discountPercentage = discountPercentageByOpportunityId.get(opportunityId);
			if (discountPercentage < 0 || discountPercentage > 100) {
				throw new TH_OpportunitiesServiceException(
					'Invalid discount of ' + discountPercentage + 'to apply to Opportunity ' + opportunityId + '.'
				);
			}
		}
		return true; 
	}
	
	public void doIfEmpty(){
		throw new TH_OpportunitiesServiceException('Opportunities not specified.');
	}
}