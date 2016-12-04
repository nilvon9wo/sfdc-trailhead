public class TH_SmsMessage {
	DAO_SmsLogDao smsLogDao;
	
	String fromNumber;
	String toNumber;
	public String message {get; private set;}

	public TH_SmsMessage (String fromNumber, String toNumber, String message, DAO_SmsLogDao smsLogDao) {
		this.fromNumber = fromNumber;
		this.toNumber = toNumber;
		this.message = message;
		
		this.smsLogDao = smsLogDao; 
	}
	
	public TH_SmsMessage (String fromNumber, String toNumber, String message) {
		this (fromNumber, toNumber, message, new DAO_SmsLogDao());
	}
	
	public String send() {
		String messageResult = 'success';
		SmsLog__c smsLog = new SmsLog__c(
			fromNumber__c = this.fromNumber,
			toNumber__c = this.toNumber, 
			messageResult__c = messageResult  
		);
		UTIL_ResultListWrapper.Result insertResult = smsLogDao.doInsert(new List<SmsLog__c>{smsLog}).get(0); 
		return stringifySendResult(insertResult);
	}
	
	private String stringifySendResult (UTIL_ResultListWrapper.Result result) {
		return result.getIsSuccess()
				? 'Successfully sent:' + this.message 
				: result.getErrorString();	
	}
}