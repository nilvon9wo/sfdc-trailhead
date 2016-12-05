@isTest
public class MOCK2_AccountFactory extends MOCK2_SObjectFactory { 

	public static List<Account> createList(Account template, Integer quantity, String defaultName, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new AccountInQuantityStrategy(template, quantity, defaultName); 
		return (List<Account>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  

	public static List<Account> createList(Account template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new AccountInQuantityStrategy(template, quantity); 
		return (List<Account>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  
	
	class AccountInQuantityStrategy extends SObjectInQuantityStrategy {
		AccountInQuantityStrategy(SObject template, Integer quantity, String defaultName) {
			super(template, quantity, defaultName);
		}

		AccountInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Account ');
		}
	}
	
	// ---------------------------------------------------------------------------------------------------------

	public static List<Account> createList(Map<String, Integer> numberOfAccountsByStateMap, TEST_DummyInsertModeEnum insertMode){
		List<Account> accountList = new List<Account>();
		for (String state : numberOfAccountsByStateMap.keySet()) {
			Account templateAccount = new Account(billingState = state);
			Integer quantity = numberOfAccountsByStateMap.get(state);
			accountList.addAll(MOCK2_AccountFactory.createList(templateAccount, quantity, TEST_DummyInsertModeEnum.LATER));
		}
		TEST_DMLHelper.doInsert(accountList, insertMode);
		return accountList;
	}	  
	
	
	
}