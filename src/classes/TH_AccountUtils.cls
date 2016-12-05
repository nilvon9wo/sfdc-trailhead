public class TH_AccountUtils {
	DAO_AccountDao accountDao;
	
	public TH_AccountUtils(DAO_AccountDao accountDao){
		this.accountDao = accountDao;
	}
	
	public TH_AccountUtils(){
		this(new DAO_AccountDao());
	}
	
	public static List<Account> accountsByState(String stateAbbreviation) {
		TH_AccountUtils utils = new TH_AccountUtils();
		return utils.getByBillingState(stateAbbreviation);
	}
	
	public List<Account> getByBillingState(String stateAbbreviation) {
		return this.accountDao.getByBillingState(stateAbbreviation);
	}
	
	public ID addParentUpdateToQueue(String billingState, String parentName) {
		List<Account> accountList = this.accountDao.getByBillingState(billingState);
		
		List<Account> parentAccountList = this.accountDao.getByName(parentName);
		Id parentId;
		if (parentAccountList.size() > 0) {
			parentId = parentAccountList[0].id;
		}
		else {
			new TH_AccountUtilException(parentName + ' is not a valid company name');			
		}

		TH_AccountUpdateParentQueueable updateJob = new TH_AccountUpdateParentQueueable(accountList, parentId);
		return System.enqueueJob(updateJob);
	}
	
	class TH_AccountUtilException extends Exception{}
}