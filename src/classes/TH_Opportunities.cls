public class TH_Opportunities extends fflib_SObjectDomain {
	List<Opportunity> opportunityList;
	Map<Id, Decimal> discountPercentageByOpportunityId;
	DAO_AccountDao accountDao;
	
	public TH_Opportunities(List<Opportunity> opportunityList, Map<Id, Decimal> discountPercentageByOpportunityId, DAO_AccountDao accountDao){
		super(opportunityList);
		if (Opportunity_Settings__c.getInstance().security_disabled__c) {
			Configuration.disableTriggerCRUDSecurity();
		}
		
		this.opportunityList = opportunityList;
		this.discountPercentageByOpportunityId = discountPercentageByOpportunityId;
		this.accountDao = accountDao;
	}
	
	public TH_Opportunities(List<Opportunity> opportunityList) {
		this(opportunityList, TH_OpportunitiesDefaultDiscounter.getDefaultDiscountMap(opportunityList), new DAO_AccountDao());
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> opportunityList) {
			return new TH_Opportunities (opportunityList);
		}
	} 
	
	public override void onApplyDefaults() {
		for (Opportunity opportunity : (List<Opportunity>) Records) {
			if (opportunity.discount_type__c == null) { 
				opportunity.discount_type__c = Opportunity_Settings__c.getInstance().discount_type__c;
			}
		}
	}
	
	public override void onAfterInsert() {
		List<Id> accountIdList = new List<Id>();
		for (Opportunity opportunity : (List<Opportunity>) Records) {
			if (opportunity.accountId != null) {
				accountIdList.add(opportunity.accountId);
			}
		}
		
		fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( 
			new Schema.SObjectType[]{ Account.SObjectType } 
		);
		TH_Accounts accounts = new TH_Accounts(this.accountDao.getByIds(accountIdList));  
		accounts.updateOpportunityActivity(unitOfWork);
		unitOfWork.commitWork();
	}
	
	public override void onValidate() {
		for (Opportunity opportunity : (List<Opportunity>) Records) {
			if (opportunity.type.startsWith('Existing') && opportunity.accountId == null) {
				opportunity.accountId.addError('You must provide an Account when creating Opportunities for existing Customers.');
			}
		}
	}

	public override void onValidate(Map<Id, SObject> existingRecords) {
		for (Opportunity opportunity : (List<Opportunity>) Records) {
			Opportunity existingOpportunity = (Opportunity) existingRecords.get(opportunity.id);
			if (opportunity.type != existingOpportunity.type) {
				opportunity.type.addError('You cannot change the Opportunity typo once it has been created.');
			}
		}
	}

	public fflib_SObjectUnitOfWork applyDiscounts(fflib_SObjectUnitOfWork unitOfWork, List<Decimal> discountList){
		
		for(Opportunity opportunity: (List<Opportunity>) Records) {
			Decimal discountPercentage = this.discountPercentageByOpportunityId.get(opportunity.id);
			Decimal factor = 1 - (discountPercentage == null ? 0 : discountPercentage / 100);
			
			TH_OpportunitiesLineItemDiscountStrategy discountStrategy = 
				new TH_OpportunitiesLineItemDiscountStrategy(unitOfWork, opportunity, factor, discountList);
					
			discountStrategy.execute(opportunity.opportunityLineItems);
		}
		
		return unitOfWork;  
	}
}