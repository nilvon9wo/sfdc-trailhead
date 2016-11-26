@isTest 
public class TH_EmailManagerTest {   
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	private static final String testSubject = 'Test Subject';
	private static final String testAddress = 'johndoe@example.com';
	private static final String testBody = 'Test Body';
	
	private static testMethod void sendMailShouldSendTheSpecifiedEmail(){
		// Arrange
		MSG_Postman mockPostman = new MockPostman(); 
		MSG_PostalInspector mockPostalInspector = new MockPostalInspector();
		TH_EmailManager managerUnderTest = new TH_EmailManager(mockPostman, mockPostalInspector);
		
		TH_Email testEmail = new TH_Email(testSubject, testAddress, testBody); 
		
		// Act
		Boolean result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = managerUnderTest.sendMail(testEmail);
            }
            Test.stopTest();
        }

		// Assert
		System.assert(result); 
	}
	
	private class MockPostman extends MSG_Postman {
		override public Messaging.SendEmailResult[] send(List<Messaging.SingleEmailMessage> messageList) { 
			Messaging.SingleEmailMessage message = messageList[0];
			
			System.assertEquals(message.getSubject(), testSubject);
			System.assertEquals(message.getToAddresses()[0], testAddress);
			System.assertEquals(message.getPlainTextBody(), testBody);
			return new Messaging.SendEmailResult[]{}; 	
		}	
	}
	
	private class MockPostalInspector extends MSG_PostalInspector {
		override public Boolean inspect(Messaging.SendEmailResult[] emailResultArray, Boolean failFast) {
			return emailResultArray != null;
		}
	}
}