@isTest
public class MOCK2_OpportunityFactory extends MOCK2_SObjectFactory { 
	private static Map<String, Object> defaultByKeyMap = new Map<String, Object>{
		'stageName' => 'Prospecting',
		'type' => 'New Customer'
	}; 

	public static List<Opportunity> createList(Opportunity template, Integer quantity, TEST_DummyInsertModeEnum insertMode){
		MockStrategyInterface strategy = new OpportunityInQuantityStrategy(template, quantity); 
		return (List<Opportunity>) MOCK2_SObjectFactory.createList(strategy, insertMode);
	}	  

	class OpportunityInQuantityStrategy extends SObjectInQuantityStrategy {
		OpportunityInQuantityStrategy(SObject template, Integer quantity) {
			super(template, quantity, 'Opportunity ', defaultByKeyMap);
		}
	}
}