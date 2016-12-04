@RestResource(urlMapping='/Account/*')
global with sharing class TH_AccountsRestResource {
	DAO_AccountDao accountDao;
	
	TH_AccountsRestResource(DAO_AccountDao accountDao) {
		this.accountDao = accountDao;
	}

	TH_AccountsRestResource() {
		this(new DAO_AccountDao());
	}
	
	@HttpGet
	global static Account getRecord(){
		TH_AccountsRestResource resource = new TH_AccountsRestResource();
		return resource.getById(RestContext.request);
	}
	
	private Account getById(RestRequest request){
		String accountId = request.requestURI
			.substring(request.requestURI.lastIndexOf('/') +1);
		 		
		List<Id> idList = new List<Id>{(Id) accountId };
		List<Account> accountList = accountDao.getByIds(idList); 
		return accountList[0];
	}
}