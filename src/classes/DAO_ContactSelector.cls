public class DAO_ContactSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Contact.firstName,
                Contact.lastName
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
}