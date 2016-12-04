public class DAO_ContactSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Contact.id,
                Contact.email,
                Contact.firstName,
                Contact.lastName,
                Contact.mailingCity,
                Contact.mailingPostalCode,
                Contact.mailingState,
                Contact.mailingStreet
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectById(Set<Id> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
}