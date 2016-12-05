public class DAO_CronJobDetailSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                CronJobDetail.id,
                CronJobDetail.name,
                CronJobDetail.jobType
        };
    }

    public Schema.SObjectType getSObjectType() {
        return CronJobDetail.sObjectType;
    }

    public List<CronJobDetail> selectById(Set<Id> idSet) {
        return (List<CronJobDetail>) selectSObjectsById(idSet);
    }
}