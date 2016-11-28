public class TRIG_OpportunitiesTriggerHandler extends fflib_SObjectDomain {
	static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork( new Schema.SObjectType[]{ 
		Opportunity.SObjectType,
		Account.SObjectType 
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
		this(opportunityList, new TH_Opportunities(opportunityList, unitOfWork), new TH_OpportunitiesValidator());
	}
	
	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> opportunityList) {
			return new TRIG_OpportunitiesTriggerHandler (opportunityList);
		} 
	}

	public override void onApplyDefaults() {
		opportunities.setDefaultDiscountTypes((List<Opportunity>) Records);
	}
	
	public override void onAfterInsert() {
		opportunities.updateOpportunityActivity((List<Opportunity>) Records);
		unitOfWork.commitWork();
	}
	 
	public override void onValidate() {
		validator.newRecordswRequireAccount((List<Opportunity>) Records);
	}

	public override void onValidate(Map<Id, SObject> existingRecords) {
		validator.typeCannotBeChanged((Map<Id, Opportunity>) existingRecords, (List<Opportunity>) Records);
	}
}