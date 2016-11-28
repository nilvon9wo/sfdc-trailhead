public class TH_OpportunitiesValidator {
	public Boolean newRecordswRequireAccount(List<Opportunity> opportunityList){
		Boolean success = true;
		for (Opportunity opportunity : opportunityList) {
			if (opportunity.type.startsWith('Existing') && opportunity.accountId == null) {
				opportunity.accountId.addError('You must provide an Account when creating Opportunities for existing Customers.');
				success = false;
			}
		}
		return success;
	} 
	
	public Boolean typeCannotBeChanged(Map<Id, Opportunity> oldOpportunityByIdMap, List<Opportunity> newOpportunityList){
		Boolean success = true;
		for (Opportunity opportunity : newOpportunityList) {
			Opportunity existingOpportunity = oldOpportunityByIdMap.get(opportunity.id);
			if (opportunity.type != existingOpportunity.type) {
				opportunity.type.addError('You cannot change the Opportunity typo once it has been created.');
			}
		}
		return success;
	}   
}