trigger OpportunitiesTrigger on Opportunity (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
	fflib_SObjectDomain.triggerHandler(TH_Opportunities.class);    
}