public with sharing class TH_EmailManager {  
	private MSG_Postman postman;
	private	MSG_PostalInspector postalInspector;
	
	public TH_EmailManager (
			MSG_Postman postman,
			MSG_PostalInspector postalInspector
		){
		this.postman = postman;
		this.postalInspector = postalInspector; 
	}

	public TH_EmailManager () {
		this(new MSG_Postman(), new MSG_PostalInspector());  
	}

	public static void send(TH_Email email) {
		TH_EmailManager manager = new TH_EmailManager();
		manager.sendMail(email);	
	}
	
	public Boolean sendMail (TH_Email email) { 
		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		message.setToAddresses(new String[] {email.address});
		message.setSubject(email.subject);
		message.setPlainTextBody(email.body);

		Messaging.SendEmailResult[] resultArray = this.postman.send(new Messaging.SingleEmailMessage[] { message });
			
		Boolean failFast = false;	
		return this.postalInspector.inspect(resultArray, failFast);			
	}
}