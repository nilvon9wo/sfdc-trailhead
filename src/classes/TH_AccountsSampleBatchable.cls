@isTest
global class TH_AccountsSampleBatchable implements Database.Batchable<sObject>, Database.Stateful {
	
	global Integer numberOfProcessedAccounts = 0;
	
	global Database.QueryLocator start(Database.BatchableContext batchableContext) {
		return Database.getQueryLocator('SELECT id, name FROM Account');
	}
	
	global void execute (Database.BatchableContext batchableContext, List<Account> accountList){
		for (Account account : accountList) {
			numberOfProcessedAccounts++;
		}
	} 
	
	global void finish(Database.BatchableContext batchableContext) {
		String subject = numberOfProcessedAccounts + ' Accounts were processed';
		String emailAddress = 'someAddress@example.com';
		String body = 'Meet me at the bar for drinks to celebrate';
		TH_EmailManager manager = new TH_EmailManager();
		manager.sendMail(new TH_Email(subject, emailAddress, body));		
	}
}