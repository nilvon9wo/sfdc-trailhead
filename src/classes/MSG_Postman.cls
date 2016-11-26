public virtual class MSG_Postman {
	
	public virtual Messaging.SendEmailResult[] send(List<Messaging.SingleEmailMessage> messageList){
		Messaging.SendEmailResult[] resultArray;
		
		if (!Test.isRunningTest()){
			return Messaging.sendEmail(messageList);
		}
		
		return resultArray;
	}    
}