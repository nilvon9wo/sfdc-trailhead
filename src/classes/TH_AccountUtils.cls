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
	
}