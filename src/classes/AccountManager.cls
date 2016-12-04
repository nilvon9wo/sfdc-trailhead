@RestResource(urlMapping='/Accounts/*/contacts') 
global class AccountManager {
	DAO_AccountDao accountDao;
	
	AccountManager(DAO_AccountDao accountDao) {
		this.accountDao = accountDao;
	}
 
	AccountManager() {
		this(new DAO_AccountDao());
	}
	
	@HttpGet
	global static Account getAccount(){
		AccountManager resource = new AccountManager();
		return resource.getById(RestContext.request);		
	}
	
	private Account getById(RestRequest request) {
		Id accountId = extractIdFromUrl(request);
		Set<Id> idSet = new Set<Id>{accountId};
		
		List<Account> accountList = this.accountDao.getWithContactsByAccountIds(idSet);
		return accountList[0];
	}
	
	private Id extractIdFromUrl(RestRequest request){
		List<String> urlParts = request.requestURI.split('/');
		String accountId = urlParts[6];
		return (Id) accountId;
	}
	
}