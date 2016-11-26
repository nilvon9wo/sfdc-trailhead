public class TH_AccountFactory {
	TH_AccountDao accountDao; 
	
	public TH_AccountFactory(TH_AccountDao accountDao){
		this.accountDao = accountDao;
	}
	
	public TH_AccountFactory(){
		this(new TH_AccountDao());
	}
	
	public Account create (String name, String phone, Integer numberOfEmployees, Boolean insertNow) {
		Account account = new Account(
			name = name,
			phone = phone,
			numberOfEmployees = numberOfEmployees
		);
		
		if (insertNow){
			this.accountDao.insertAccount(account);
		}
		
		return account;
	}    

	public Account create (String name, String phone, Integer numberOfEmployees) {
		return this.create(name, phone, numberOfEmployees, false);
	}    

	public Account create (String name) {
		return this.create(name, null, null, false);
	}    
}