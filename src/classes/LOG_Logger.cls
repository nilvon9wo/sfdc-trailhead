public virtual class LOG_Logger {
	private Map<System.LoggingLevel, String> prefixCharByLoggingLevel = new Map<System.LoggingLevel, String>{
		System.LoggingLevel.DEBUG => '#',
		System.LoggingLevel.INFO => '.',
		System.LoggingLevel.ERROR => '!'
	};

	public String debug(String message){
		return this.debug(System.LoggingLevel.DEBUG, message);
	} 

	public String info(String message){
		return this.debug(System.LoggingLevel.INFO, message);
	} 
	    
	public String error(String message){
		return this.debug(System.LoggingLevel.ERROR, message);
	} 
	
	private String debug (System.LoggingLevel level, String message) {
		String prefix = prefixCharByLoggingLevel.get(level).repeat(5);
		String output = prefix + ' ' + message;
		
		System.debug(level, output);
		return output;
	}
}