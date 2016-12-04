public class DAO_CaseSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Case.id,
                Case.caseNumber,
                Case.subject,
                Case.status,
                Case.origin,
                Case.priority
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Case.sObjectType;
    }

    public List<Case> selectById(Set<Id> idSet) {
        return (List<Case>) selectSObjectsById(idSet);
    }    
}