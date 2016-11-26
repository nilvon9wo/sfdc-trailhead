public class TH_GenericSObjectWorker {
	SObject sObj;

	public Account setToAccount(String name){
		return (Account) setAndReturn(new Account(name = name));
	}

	public TH_Book__c setToBook(String name){
		return (TH_Book__c) setAndReturn(new TH_Book__c(name = name));
	}
	
	private SObject setAndReturn(SObject sObj){
		this.sObj = sObj;
		return this.sObj; 
	}
}