@isTest
public class MOCK2_AccountFactory extends MOCK2_SObjectFactory { 
	public static List<Account> createList(Account template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new AccountInQuantityStrategy(template, quantity); 
		return (List<Account>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  
	
	class AccountInQuantityStrategy extends SObjectInQuantityStrategy {
		AccountInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Account ');
		}
	}
}