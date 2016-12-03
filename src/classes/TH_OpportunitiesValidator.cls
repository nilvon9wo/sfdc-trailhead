public class TH_OpportunitiesValidator {
	List<Opportunity> opportunityList;
	
	public TH_OpportunitiesValidator(List<Opportunity> opportunityList) {
		this.opportunityList = opportunityList;
	}

	public Boolean newRecordsRequireType(){
		Boolean success = true;
		for (Opportunity opportunity : this.opportunityList) {
			if ( opportunity.type == null ) {
				opportunity.accountId.addError('You must provide a Type when creating Opportunities.');
				success = false;
			}
		}
		return success;
	} 

	public Boolean newRecordsRequireAccount(){
		Boolean success = true;
		for (Opportunity opportunity : this.opportunityList) {
			if ( opportunity.type != null 
					&& opportunity.type.startsWith('Existing') 
					&& opportunity.accountId == null
				) {
				opportunity.accountId.addError('You must provide an Account when creating Opportunities for existing Customers.');
				success = false;
			}
		}
		return success;
	} 
	
	public Boolean typeCannotBeChanged(Map<Id, Opportunity> oldOpportunityByIdMap){
		Boolean success = true;
		for (Opportunity opportunity : this.opportunityList) {
			Opportunity existingOpportunity = oldOpportunityByIdMap.get(opportunity.id);
			if (opportunity.type != existingOpportunity.type) {
				opportunity.type.addError('You cannot change the Opportunity typo once it has been created.');
			}
		}
		return success;
	}   
}