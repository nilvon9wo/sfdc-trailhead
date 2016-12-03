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
	
	

	public static Map<SObjectType, List<SObject>> createWithOpportunityList(
			Integer accountQuantity, 
			Integer opportunityPerAccountQuantity, 
			TEST_DummyInsertModeEnum insertMode
		) {
		for (Integer i = 1; i <= accountQuantity; i++) {
			create(i, opportunityPerAccountQuantity);
		} 
		 
		unitOfWork.commitWork(insertMode);
		return sObjectListBySObjectMap;
	}
	
	private static Account create(Integer i, Integer opportunityPerAccountQuantity){
		Account account = create(unitOfWork, i);				
 
 		if (opportunityPerAccountQuantity > 0) {
			for (Integer j = 1; j <= opportunityPerAccountQuantity; j++) {
	 			System.debug('####### Creating Opportunity : ' + j);
				createRelationships(account, i, j);
			}  
 		}
		sObjectListBySObjectMap.get(Account.getSObjectType()).add(account);
		return account;
	} 
	 
	private static Map<SObjectType, List<SObject>> createRelationships (Account account, Integer i, Integer j){
		Opportunity opportunity = MOCK_OpportunityFactory.createWithAccount(unitOfWork, account, i);
		sObjectListBySObjectMap.get(Opportunity.getSObjectType()).add(opportunity);
		return sObjectListBySObjectMap;
	}
	
	// ------------------------------------------------------------------------------------
	
	private static fflib_SObjectUnitOfWork createUnitOfWork() {
		return new fflib_SObjectUnitOfWork (
			new Schema.SObjectType[]{
				Account.SObjectType,
				Opportunity.SObjectType
			}
		);
	}
	
	private static Map<SObjectType, List<SObject>> createSObjectListBySObjectMap(){
		return new Map<SObjectType, List<SObject>> {
			Account.getSObjectType() => new List<Account>(),
			Opportunity.getSObjectType() => new List<Opportunity>()
		};
	}
	
	
	
	
}