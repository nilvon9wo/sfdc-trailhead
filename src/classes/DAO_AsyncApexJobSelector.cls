public class DAO_AsyncApexJobSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                AsyncApexJob.id,
                AsyncApexJob.jobItemsProcessed,
                AsyncApexJob.numberOfErrors,
                AsyncApexJob.status,
                AsyncApexJob.totalJobItems
        };
    }

    public Schema.SObjectType getSObjectType() {
        return AsyncApexJob.sObjectType;
    }

    public List<AsyncApexJob> selectById(Set<Id> idSet) {
        return (List<AsyncApexJob>) selectSObjectsById(idSet);
    }
    
    public List<AsyncApexJob> selectWithCreaterByJobId(Set<Id> idSet) {
    	fflib_QueryFactory asyncApexJobQueryFactory = newQueryFactory(); 
    	
    	new DAO_UserSelector().configureQueryFactoryFields(asyncApexJobQueryFactory, 'createdBy.email');
    	
    	return (List<AsyncApexJob>) Database.query(
    		asyncApexJobQueryFactory
    		.setCondition('id in :idSet')
    		.toSOQL()
    	);
    }
    
}