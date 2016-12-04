public class UTIL_MapIdentifierHelper 
{
	/**
	 * This function is used to create unique identifiers for sObjects which may not already have an SFDC Id.
	 * (e.g. because it hasn't been inserted yet.)
	 *
	 * Only "stable" values should be used so the calculation can be repeated with the same result.
	 * (e.g. first to put a record in a map and [possibly much] later to retrieve it.) 
	 **/  	
	public static String create (SObject currentSobject, Boolean useNonNullId)
	{
		if (useNonNullId)
		{
			// If sObject already has an id, we can/should use it, and it alone (unless we can't)
			if (currentSObject.get('id') != null) { return (String) currentSObject.get('id'); } 
		}

		if (currentSObject.getSObjectType() == Account.SObjectType)     { return create ((Account)  		  currentSobject); }
		if (currentSObject.getSObjectType() == Attachment.SObjectType)  { return create ((Attachment) 		  currentSobject); }
		if (currentSObject.getSObjectType() == Case.SObjectType)     	{ return create ((Case)     		  currentSobject); }
		if (currentSObject.getSObjectType() == Contact.SObjectType)     { return create ((Contact) 		  	  currentSobject); }
		if (currentSObject.getSObjectType() == Document.SObjectType)    { return create ((Document)		  	  currentSobject); }
		if (currentSObject.getSObjectType() == Lead.SObjectType)    { return create ((Lead)		  	  currentSobject); }
		if (currentSObject.getSObjectType() == Opportunity.SObjectType) { return create ((Opportunity)		  currentSobject); }
		if (currentSObject.getSObjectType() == SmsLog__c.SObjectType)   { return create ((SmsLog__c)		  currentSobject); }

		// TODO: Modify this code to create unique Ids for more SObjects, which will usually have different fields.
		throw new MapIdentifierUndefinedException('No map identifier has been defined for : ' + currentSObject.getSObjectType());
	}

	public static String create (SObject currentSobject) { return create (currentSobject, true); }
	public static String create (Account    account)     { return 'Account' + concatenate(account, new List<String>{ 'name' });  			}
	public static String create (Attachment attachment)  { return 'Attachment' + concatenate(attachment, new List<String>{ 'name', 'parentId'});  			}
	public static String create (Case       currentCase) { return 'Case' + concatenate(currentCase, new List<String>{ 'subject', 'priority', 'origin'});  			}
	public static String create (Contact    contact)	 { return 'Contact'    + concatenate(contact, new List<String>{ 'lastName', 'firstName', 'email'}); }
	public static String create (Document   document)	 { return 'Document'   + concatenate(document,   new List<String>{ 'name', 'contentType', 'type', 'folderId'}); }
	public static String create (Lead   lead)	         { return 'Lead'   + concatenate(lead,   new List<String>{ 'lastName', 'firstName', 'company', 'leadSource'}); }
	public static String create (Opportunity opportunity){ return 'Opportunity'+ concatenate(opportunity, new List<String>{ 'name', 'type', 'accountId'}); }
	public static String create (SmsLog__c  smsLog){ return 'SmsLog__c'+ concatenate(smsLog, new List<String>{ 'fromNumber__c', 'toNumber__c', 'messageResult__c'}); }

	@testVisible private static String concatenate(SObject currentSobject, List<String> fieldNameList)
	{
		String value = '';
		for (String fieldName : fieldNameList) { value += (String) currentSobject.get(fieldName); }
		return value;
	}

    @testVisible private static String getDatePartString (SObject currentSObject, String fieldName)
    {
        return (currentSObject.get (fieldName) != null) 
                   ? ((Datetime) currentSObject.get (fieldName)).format('yyyy/mm/dd') 
                   : (fieldName + '=NULL');
    }

	private class MapIdentifierUndefinedException extends Exception {}
}