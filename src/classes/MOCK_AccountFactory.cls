@isTest
public class MOCK_AccountFactory {
	public static String defaultBillingState = 'CA';
	
	public static List<Account> createList(fflib_SObjectUnitOfWork unitOfWork, Integer quantity) {
		List<Account> accountList = new List<Account>(); 
		for (Integer i = 1; i <= quantity; i++){
			accountList.add(create(unitOfWork, i)); 
		}
		return accountList;
	}
	
	public static Account create(fflib_SObjectUnitOfWork unitOfWork, Integer i) {
		Account account = create(unitOfWork, 'Challange Complete Test Account ' + i);
		return account; 
	}

	public static Account create(fflib_SObjectUnitOfWork unitOfWork, String name) {
		Account account = new Account(
			name = name,
			billingState = defaultBillingState
		);
		unitOfWork.registerNew(account);
		return account;
	}
}