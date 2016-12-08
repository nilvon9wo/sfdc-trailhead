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
                Contact.mailingStreet,
                Contact.title
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectById(Set<Id> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
    
	public virtual List<Contact> selectList(String sortOrder, Integer recordLimit) {
		String query = String.format(
			'SELECT {0} FROM {1} ORDER BY {2} ASC LIMIT {3}',
			new List<String>{ 
				getFieldListString(), 
				getSObjectName(),
				sortOrder, 
				String.valueOf(recordLimit)
			}
		);
		return Database.query(query);
	}
    
}