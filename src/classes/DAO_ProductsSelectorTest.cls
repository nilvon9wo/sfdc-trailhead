@isTest
private class DAO_ProductsSelectorTest {
    static fflib_SObjectUnitOfWork unitOfWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[]{
            Product2.SObjectType
    });
    private static final User TestRunner = TEST_RunAsUserFactory.create();

    private static testMethod void shouldSelectTheExpectedFieldsAndValues() {
        // Arrange
        String testProductName = 'CoolItem';
        String testProductDescription = 'Something cool';
        String testText = 'My Text Field';
        Boolean testIsActive = true;
        Product2 testProduct = MOCK_ProductFactory.create(unitOfWork, new Product2(
                name = testProductName,
                description = testProductDescription,
                TH_Text__c = testText,
                isActive = testIsActive
        ));
        unitOfWork.commitWork(TEST_DummyInsertModeEnum.REAL);

        // Act
        List<Product2> resultList;
        System.runAs(TestRunner) {
            Test.startTest();
            {
                resultList = new DAO_ProductsSelector(true).selectById(new Set<Id>{
                        testProduct.id
                });
            }
            Test.stopTest();
        }

        // Assert
        System.assertEquals(resultList[0].name, testProductName);
        System.assertEquals(resultList[0].description, testProductDescription);
        System.assertEquals(resultList[0].TH_Text__c, testText);
        System.assertEquals(resultList[0].isActive, testIsActive);
    }
}