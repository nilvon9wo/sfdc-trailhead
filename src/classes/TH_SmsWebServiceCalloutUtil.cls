public class TH_SmsWebServiceCalloutUtil {
	@future(callout=true)
	public static void sendAync (String fromNumber, String toNumber, String message) {
		TH_SmsMessage smsMessage = new TH_SmsMessage(fromNumber, toNumber, message); 
		String results = send(smsMessage); 
		
		LOG_Logger logger = new LOG_Logger();
		logger.info(results);
	}

	public static String send (String fromNumber, String toNumber, String message) {
		TH_SmsMessage smsMessage = new TH_SmsMessage(fromNumber, toNumber, message); 
		return send(smsMessage);
	}

	public static String send (TH_SmsMessage smsMessage) { 
		return smsMessage.send();    
	}
}