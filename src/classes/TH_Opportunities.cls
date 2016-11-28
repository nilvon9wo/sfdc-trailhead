public class TH_Opportunities {
	fflib_SObjectUnitOfWork unitOfWork;
	List<Opportunity> opportunityList; 
	Map<Id, Decimal> discountPercentageByOpportunityId;
	DAO_AccountDao accountDao;
	
	public TH_Opportunities(
			List<Opportunity> opportunityList, 
			fflib_SObjectUnitOfWork unitOfWork, 
			Map<Id, Decimal> discountPercentageByOpportunityId, 
			DAO_AccountDao accountDao
		){
		this.opportunityList = opportunityList; 
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
		this.accountDao = accountDao;
		this.unitOfWork = unitOfWork;
	}
	
	public TH_Opportunities(List<Opportunity> opportunityList, fflib_SObjectUnitOfWork unitOfWork) {
		this(opportunityList, unitOfWork, TH_OpportunitiesDefaultDiscounter.getDefaultDiscountMap(opportunityList), new DAO_AccountDao());
	}
	
	public TH_Opportunities setDefaultDiscountTypes(List<Opportunity> opportunityList){
		for (Opportunity opportunity : opportunityList) {
			if (opportunity.discount_type__c == null) { 
				opportunity.discount_type__c = Opportunity_Settings__c.getInstance().discount_type__c;
				unitOfWork.registerDirty(opportunity);
			}
		}
		return this;
	}

	public TH_Opportunities applyDiscounts(List<Decimal> discountList){
		for(Opportunity opportunity: opportunityList) {
			Decimal discountPercentage = this.discountPercentageByOpportunityId.get(opportunity.id);
			Decimal factor = 1 - (discountPercentage == null ? 0 : discountPercentage / 100);
			
			TH_OpportunitiesLineItemDiscountStrategy discountStrategy = 
				new TH_OpportunitiesLineItemDiscountStrategy(this.unitOfWork, opportunity, factor, discountList);
					
			discountStrategy.execute(opportunity.opportunityLineItems);
		}
		return this;  
	}

	public TH_Opportunities updateOpportunityActivity(List<Opportunity> opportunityList){
		List<Id> accountIdList = new List<Id>();
		for (Opportunity opportunity : opportunityList) {
			if (opportunity.accountId != null) {
				accountIdList.add(opportunity.accountId);
			}
		}
		
		TH_Accounts accounts = new TH_Accounts(accountDao.getByIds(accountIdList), unitOfWork);  
		accounts.updateOpportunityActivity();
		return this;
	}
}