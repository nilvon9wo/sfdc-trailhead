@isTest
public class MOCK_AccountFactory {
	public static String defaultBillingState = 'CA';

	private static fflib_SObjectUnitOfWork unitOfWork = createUnitOfWork();
	private static Map<SObjectType, List<SObject>> sObjectListBySObjectMap = createSObjectListBySObjectMap();
	
	public static List<Account> createList(fflib_SObjectUnitOfWork unitOfWork2, Integer quantity) {
		List<Account> accountList = new List<Account>(); 
		for (Integer i = 1; i <= quantity; i++){
			accountList.add(create(unitOfWork2, i)); 
		}
		return accountList;
	}
	
	public static Account create(fflib_SObjectUnitOfWork unitOfWork2, Integer i) {
		Account account = create(unitOfWork2, 'Test Account ' + i);
		return account; 
	}

	public static Account create(fflib_SObjectUnitOfWork unitOfWork2, String name) {
		Account account = new Account(
			name = name,
			billingState = defaultBillingState
		);
		unitOfWork2.registerNew(account);
		return account;
	}
	
	// --------------------------------------------------------------------------------------
	
	public static Map<SObjectType, List<SObject>> createWithContactList(
			Integer accountQuantity, 
			Integer contactsPerAccountQuantity, 
			TEST_DummyInsertModeEnum insertMode
		) {
		for (Integer i = 1; i <= accountQuantity; i++) {
			createWithContact(i, contactsPerAccountQuantity);
		} 
		 
		unitOfWork.commitWork(insertMode);
		 
		// This is shitty hack
		List<Account> accountList = sObjectListBySObjectMap.get(Account.getSObjectType());
		List<Contact> contactList = sObjectListBySObjectMap.get(Contact.getSObjectType());
		
		for (Account account : accountList) {
			for (Integer i = 1; i <= contactsPerAccountQuantity; i++) {
				contactList[i-1].accountId = account.id;
			}
		}

		if (insertMode == TEST_DummyInsertModeEnum.REAL) {
			upsert (contactList);
		}
		else if (insertMode == TEST_DummyInsertModeEnum.MOCK) {
			TEST_MockDMLHelper.mockInsert(contactList);
		}
		
		return sObjectListBySObjectMap;
	}
	
	private static Account createWithContact(Integer i, Integer contactsPerAccountQuantity){
		Account account = create(unitOfWork, i);				
 
 		if (contactsPerAccountQuantity > 0) {
			for (Integer j = 1; j <= contactsPerAccountQuantity; j++) {
				createRelationshipsToContacts(account, i, j);
			}  
 		}
		sObjectListBySObjectMap.get(Account.getSObjectType()).add(account);
		return account;
	} 
	 
	private static Map<SObjectType, List<SObject>> createRelationshipsToContacts (Account account, Integer i, Integer j){
		Contact contact = MOCK_ContactFactory.createWithAccount(unitOfWork, account, i);
		sObjectListBySObjectMap.get(Contact.getSObjectType()).add(contact);
		return sObjectListBySObjectMap;
	}
	
	// --------------------------------------------------------------------------------------
 
	public static Map<SObjectType, List<SObject>> createWithOpportunityList(
			Integer accountQuantity, 
			Integer opportunitysPerAccountQuantity, 
			TEST_DummyInsertModeEnum insertMode
		) {
		for (Integer i = 1; i <= accountQuantity; i++) {
			createWithOpportunity(i, opportunitysPerAccountQuantity);
		} 
		 
		unitOfWork.commitWork(insertMode);
		return sObjectListBySObjectMap;
	}
	
	private static Account createWithOpportunity(Integer i, Integer opportunitysPerAccountQuantity){
		Account account = create(unitOfWork, i);				
 
 		if (opportunitysPerAccountQuantity > 0) {
			for (Integer j = 1; j <= opportunitysPerAccountQuantity; j++) {
				createRelationshipsToOpportunities(account, i, j);
			}  
 		}
		sObjectListBySObjectMap.get(Account.getSObjectType()).add(account);
		return account;
	} 
	 
	private static Map<SObjectType, List<SObject>> createRelationshipsToOpportunities (Account account, Integer i, Integer j){
		Opportunity opportunity = MOCK_OpportunityFactory.createWithAccount(unitOfWork, account, i);
		sObjectListBySObjectMap.get(Opportunity.getSObjectType()).add(opportunity);
		return sObjectListBySObjectMap;
	}
	
	// ------------------------------------------------------------------------------------
	
	private static fflib_SObjectUnitOfWork createUnitOfWork() {
		return new fflib_SObjectUnitOfWork (
			new Schema.SObjectType[]{
				Account.SObjectType,
				Contact.SObjectType,
				Opportunity.SObjectType
			}
		);
	}
	
	private static Map<SObjectType, List<SObject>> createSObjectListBySObjectMap(){
		return new Map<SObjectType, List<SObject>> {
			Account.getSObjectType() => new List<Account>(),
			Contact.getSObjectType() => new List<Contact>(),
			Opportunity.getSObjectType() => new List<Opportunity>()
		};
	}
	
	
	
	
}