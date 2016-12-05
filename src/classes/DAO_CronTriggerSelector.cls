public class DAO_CronTriggerSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                CronTrigger.timesTriggered,
                CronTrigger.nextFireTime
        };
    }

    public Schema.SObjectType getSObjectType() {
        return CronTrigger.sObjectType;
    }

    public List<CronTrigger> selectById(Set<Id> idSet) {
        return (List<CronTrigger>) selectSObjectsById(idSet);
    }
    
    public List<CronTrigger> selectByIdWithJobDetails(Set<Id> idSet) {
        fflib_QueryFactory cronTriggerQueryFactory = newQueryFactory();
        fflib_QueryFactory cronJobDetailsQueryFactory = new DAO_CronJobDetailSelector()
                .addQueryFactorySubselect(cronTriggerQueryFactory);

        return (List<CronTrigger>) Database.query(
                cronTriggerQueryFactory.setCondition('id IN :idSet').toSOQL()
        );
    }  
    
}