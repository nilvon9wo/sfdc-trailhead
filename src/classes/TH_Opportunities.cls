public class TH_Opportunities {
	DAO_UnitOfWork unitOfWork;
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
		this.unitOfWork = new DAO_UnitOfWork(unitOfWork);
	}

	public TH_Opportunities(List<Opportunity> opportunityList, fflib_SObjectUnitOfWork unitOfWork) {
		this(
			opportunityList, 
			unitOfWork, 
			TH_OpportunitiesDefaultDiscounter.getDefaultDiscountMap(opportunityList), 
			new DAO_AccountDao()
		);
	}
	
	// ---------------------------------------------------------------------------------------

	public TH_Opportunities setDefaultDiscountTypes(){
		for (Opportunity opportunity : this.opportunityList) {
			if (opportunity.discountType__c == null) {
				opportunity.discountType__c = Opportunity_Settings__c.getInstance().discount_type__c;
				if (opportunity.id != null){
					unitOfWork.register(opportunity);
				} else {
					unitOfWork.register(opportunity);
				}
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

	public TH_Opportunities updateOpportunityActivity(){ 
		List<Id> accountIdList = new List<Id>();
		for (Opportunity opportunity : this.opportunityList) {
			if (opportunity.accountId != null) {
				accountIdList.add(opportunity.accountId);
			}
		}
		
		TH_Accounts accounts = new TH_Accounts(accountDao.getByIds(accountIdList), unitOfWork);  
		accounts.updateOpportunityActivity();
		return this;
	}
	
	// ------------------------------------------------------------------------------
	
	public TH_Opportunities createWonFollowUpTask(){
		List <Task> newTaskList = new List<Task>();
		for(Opportunity opportunity : this.opportunityList) {
			if (opportunity.stageName == 'Closed Won') {
				Task task = new Task (
					subject = 'Follow Up Test Task',
					whatId = opportunity.id
				);
				newTaskList.add(task);
			}
		}
		insert newTaskList;
		return this;		
	}
}