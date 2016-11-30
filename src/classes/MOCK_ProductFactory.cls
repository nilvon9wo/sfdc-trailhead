@isTest
public class MOCK_ProductFactory {
    public static Product2 create(fflib_SObjectUnitOfWork unitOfWork, Product2 product) {
        unitOfWork.registerNew(product);
        return product;
    }


    public static Product2 create(fflib_SObjectUnitOfWork unitOfWork, String productName) {
        Product2 product =  new Product2(
                name = productName,
                description = 'Something cool',
                TH_Text__c = 'My Text Field',
                isActive = true
        );
        return create(unitOfWork, product);
    }

	public static Product2 create(fflib_SObjectUnitOfWork unitOfWork, Opportunity opportunity, Integer i) {
        return create(unitOfWork, opportunity.name + ' : Product : ' + i);
	}

    public static Product2 create(fflib_SObjectUnitOfWork unitOfWork) {
        return create(unitOfWork, 'CoolItem');
    }

}