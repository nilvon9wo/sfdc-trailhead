@isTest
public class MOCK_ProductFactory {
	public static Product2 create(fflib_SObjectUnitOfWork unitOfWork, Opportunity opportunity, Integer i) {
		Product2 product =  new Product2(name = opportunity.name + ' : Product : ' + i);
		unitOfWork.registerNew(product);
		return product; 
	}
}
