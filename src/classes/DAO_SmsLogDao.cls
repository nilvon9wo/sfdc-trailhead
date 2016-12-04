public class DAO_SmsLogDao {
    public virtual UTIL_ResultListWrapper doInsert(List<SmsLog__c> smsList) {
        return DAO_SObjectDMLHelper.doInsert(smsList);
    }
}