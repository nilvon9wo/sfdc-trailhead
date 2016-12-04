global class TH_AccountsSoapWebService {
	webservice static Account getRecord(String id) {
		DAO_AccountDao accountDao = new DAO_AccountDao(); 		
		List<Id> idList = new List<Id>{(Id)id };
		List<Account> accountList = accountDao.getByIds(idList); 
		return accountList[0];
	}
}