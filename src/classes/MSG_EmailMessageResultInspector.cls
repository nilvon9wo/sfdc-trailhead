public class MSG_EmailMessageResultInspector {
	private LOG_Logger logger;

	public MSG_EmailMessageResultInspector (LOG_Logger logger){
		this.logger = logger; 
	}

	public MSG_EmailMessageResultInspector () {
		this(new LOG_Logger()); 
	}
	
	public Boolean inspect(Object[] resultArray, Boolean failFast) {
		Messaging.SendEmailResult[] emailResultArray = (Messaging.SendEmailResult[]) resultArray;
		Boolean sendResult = true;
		
		for (Messaging.SendEmailResult result: emailResultArray) {
			if (result.isSuccess()) {
				this.logger.info('Email sent successfully.');
			}
			else {
				sendResult = false;
				this.logger.error('The following errors occurred: ' + result.getErrors());
				if (failFast) {
					return false;
				}
			}
		}
		
		return sendResult;
	}	    
}