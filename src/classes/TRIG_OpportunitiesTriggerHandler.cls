public class TRIG_OpportunitiesTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( new Schema.SObjectType[]{ 
		Account.SObjectType, 
		Opportunity.SObjectType, 
		Task.SObjectType 
	});
  
	List<Opportunity> opportunityList;
	TH_Opportunities opportunities;
	TH_OpportunitiesValidator validator; 

	public TRIG_OpportunitiesTriggerHandler(List<Opportunity> opportunityList, TH_Opportunities opportunities, TH_OpportunitiesValidator validator) {
		super(opportunityList);
		if (Opportunity_Settings__c.getInstance().security_disabled__c) {
			Configuration.disableTriggerCRUDSecurity();
		}
		this.opportunities = opportunities;
		this.validator = validator;
	}
  
	public TRIG_OpportunitiesTriggerHandler(List<Opportunity> opportunityList) {
		this(opportunityList, new TH_Opportunities(opportunityList, unitOfWork), new TH_OpportunitiesValidator(opportunityList));
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> opportunityList) {
			return new TRIG_OpportunitiesTriggerHandler (opportunityList);
		} 
	}
 
	public override void onApplyDefaults() {
		opportunities.setDefaultDiscountTypes();
	}
	
	public override void onAfterInsert() {
		opportunities.updateOpportunityActivity()
			.createWonFollowUpTask();
	} 
	 
	public override void onBeforeUpdate(Map<Id,SObject> existingAccountMap) {
		opportunities.createWonFollowUpTask();
	}

	public override void onValidate() {
		validator.newRecordsRequireType();
		validator.newRecordsRequireAccount();
	}

	public override void onValidate(Map<Id, SObject> existingRecords) {
		validator.typeCannotBeChanged((Map<Id, Opportunity>) existingRecords);
	}
}