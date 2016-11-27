public class TH_AccountFactory {
	DAO_AccountDao accountDao; 
	
	public TH_AccountFactory(DAO_AccountDao accountDao){
		this.accountDao = accountDao;
	}
	
	public TH_AccountFactory(){
		this(new DAO_AccountDao());
	}
	
    public static Account insertNewAccount(String name) {
    	if (name != null && name != '') {
	    	TH_AccountFactory factory = new TH_AccountFactory();
    		return factory.create(name, null, null, DAO_Timing.NOW);
    	}
    	else {
    		return null;
    	}
    }
	
	public Account create (String name, String phone, Integer numberOfEmployees, Boolean insertNow) {
		Account account = new Account(
			name = name,
			phone = phone,
			numberOfEmployees = numberOfEmployees
		);
		
		if (insertNow){
			this.accountDao.doInsert(account);
		}
		
		return account;
	}    

	public Account create (String name, String phone, Integer numberOfEmployees) {
		return this.create(name, phone, numberOfEmployees, DAO_Timing.LATER);
	}    

	public Account create (String name) {
		return this.create(name, null, null, DAO_Timing.LATER);
	}    
}