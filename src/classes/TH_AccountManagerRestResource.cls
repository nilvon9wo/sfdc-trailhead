@RestResource(urlMapping='/Accounts/*/contacts')
global class TH_AccountManagerRestResource {
	DAO_AccountDao accountDao;
	
	TH_AccountManagerRestResource(DAO_AccountDao accountDao) {
		this.accountDao = accountDao;
	}
 
	TH_AccountManagerRestResource() {
		this(new DAO_AccountDao());
	}
	
	@HttpGet
	global static Account getAccount(){
		TH_AccountManagerRestResource resource = new TH_AccountManagerRestResource();
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