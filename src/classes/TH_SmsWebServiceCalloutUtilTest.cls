@isTest
private class TH_SmsWebServiceCalloutUtilTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testSendSms(){
		// Arrange
		Test.setMock(HttpCalloutMock.class, new TH_SmsWebServiceCalloutMock());

		String testFrom = '111';
		String testTo = '222';
		String testMessage = 'Greetings!';

		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                TH_SmsWebServiceCalloutUtil.sendAync(testFrom, testTo, testMessage);
            }
            Test.stopTest();
        }

		// Assert
		List<SmsLog__c> logList = [ SELECT messageResult__c from SmsLog__c ];
		System.assertEquals(1, logList.size());
		System.assertEquals('success', logList[0].messageResult__c);
	}
}