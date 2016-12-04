@isTest
public class MOCK2_LeadFactory extends MOCK2_SObjectFactory { 
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
		'company' => 'company'
	}; 

	public static List<Lead> createList(Lead template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new LeadInQuantityStrategy(template, quantity); 
		return (List<Lead>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  
	
	class LeadInQuantityStrategy extends SObjectInQuantityStrategy {
		LeadInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Lead ', defaultByKeyMap);
		}
	}
}