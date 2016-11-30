public with sharing class TH_HelloWorld {
	LOG_Logger logger;
	
	public TH_HelloWorld(LOG_Logger logger){
		this.logger = logger;
	}

	public TH_HelloWorld(){
		this(new LOG_Logger());
	}
	
    public void printMessage() {
    	String message = 'Hello World';
    	this.logger.info(message);
    }
}