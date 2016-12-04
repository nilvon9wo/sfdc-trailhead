global class TH_AccountContractAddressUpdateBatchable implements Database.Batchable<sObject>,  Database.Stateful {
	DAO_AccountDao accountDao;
	DAO_AsyncApexJobSelector asyncApexJobSelector; 
	DAO_ContactDao contactDao;
	LOG_Logger logger;
	TH_EmailManager emailManager;
	
	global Integer recordsProcessed = 0;

	public TH_AccountContractAddressUpdateBatchable (
			DAO_AccountDao accountDao, 
			DAO_AsyncApexJobSelector asyncApexJobSelector, 
			DAO_ContactDao contactDao, 
			LOG_Logger logger,
			TH_EmailManager emailManager
		) {
		this.accountDao = accountDao;
		this.asyncApexJobSelector = asyncApexJobSelector;
		this.contactDao = contactDao;
		this.logger = logger;
		this.emailManager = emailManager;
	}

	public TH_AccountContractAddressUpdateBatchable() {
		this(new DAO_AccountDao(), new DAO_AsyncApexJobSelector(), new DAO_ContactDao(), new LOG_Logger(), new TH_EmailManager());
	}

    global Database.QueryLocator start(Database.BatchableContext bc) {
        //return accountDao.getLocatorWithContactsByBillingCountry('USA');
        Database.queryLocator locator = Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, BillingPostalCode, ' +
            	'(SELECT ID, MailingStreet, MailingCity, MailingState, MailingPostalCode FROM Contacts) '+
            'FROM Account ' +
            'WHERE BillingCountry = \'USA\''
        );
        console.log('locator', locator);
        return locator;
    }

    global void execute(Database.BatchableContext bc, List<Account> accountList){
    	System.debug('############ HELLO!!!!');
    	console.log('BatchableContext', bc);
    	console.log('accountList', accountList);
    	
    	List<Contact> contactList = new List<Contact>();
    	for (Account account : accountList) {
	    	console.log('account', account);
    		for (Contact contact : account.contacts) {
    			console.log('BEFORE', contact);
    			contact.MailingStreet = account.BillingStreet;
    			contact.MailingCity = account.BillingCity;
    			contact.MailingState = account.BillingState;
    			contact.MailingPostalCode = account.BillingPostalCode;
    			contactList.add(contact);
    			console.log('AFTER', contact);
    			recordsProcessed++;
    		}
    	}
    	console.log('recordsProcessed', recordsProcessed);
    	UTIL_ResultListWrapper result = contactDao.doUpdate(contactList);
    	console.log('doUpdate', result.get(0).getErrorString());
    }    

    global void finish(Database.BatchableContext bc){
        this.logger.info('Records processed: ' + recordsProcessed + '... Shazam!');
        
        Set<Id> jobIdSet = new Set<Id>{ bc.getJobId() };
        List<AsyncApexJob> jobList = [
        	SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()
        ];
 
        AsyncApexJob job = jobList[0];
        
        TH_Email email = new TH_Email(
        	'TH_AccountContractAddressUpdateBatchable Finished', 
        	job.createdBy.email, 
        	'Records processed: ' + recordsProcessed
        );
        this.emailManager.sendMail(email);
    }    

}