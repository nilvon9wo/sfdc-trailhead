@isTest
public class MOCK2_ContactFactory extends MOCK2_SObjectFactory {
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
		'firstName' => 'first',
		'lastName' => 'last'
	}; 
	
	public static List<Contact> createList(Contact template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new ContactInQuantityStrategy(template, quantity); 
		return (List<Contact>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  
	
	class ContactInQuantityStrategy extends SObjectInQuantityStrategy {
		ContactInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Contact ', defaultByKeyMap);
		}
	}
	
	public static List<Contact> createList(
			Contact template, Integer quantity, List<Account> accountList, TEST_DummyInsertModeEnum insertMode
		){
		MockStrategyInterface strategy = new nContactsPerAccountStrategy(template, quantity, accountList); 
		return (List<Contact>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  
 
	class nContactsPerAccountStrategy extends nSObjectPerRelatedSObjectStrategy {
		nContactsPerAccountStrategy(SObject template, Integer quantity, List<Account> accountList) {
			super(template, quantity, 'Contact ', 'accountId', accountList, defaultByKeyMap);
		}
	}
}