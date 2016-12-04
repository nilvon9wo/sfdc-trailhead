public virtual class MSG_PostalInspector {
	private LOG_Logger logger;

	public MSG_PostalInspector (LOG_Logger logger){
		this.logger = logger; 
	}

	public MSG_PostalInspector () {
		this(new LOG_Logger()); 
	}
	
	public virtual Boolean inspect(Messaging.SendEmailResult[] emailResultArray, Boolean failFast) {
		Boolean sendResult = true;
		
		if (emailResultArray != null) {
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
		}
		
		return sendResult;
	}	    
}