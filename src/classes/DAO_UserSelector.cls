public class DAO_UserSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                User.id,
                User.email
        };
    }

    public Schema.SObjectType getSObjectType() {
        return User.sObjectType;
    }

    public List<AsyncApexJob> selectById(Set<Id> idSet) {
        return (List<AsyncApexJob>) selectSObjectsById(idSet);
    }
}