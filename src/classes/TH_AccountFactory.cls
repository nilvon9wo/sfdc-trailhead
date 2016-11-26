public class TH_AccountFactory {
	DAO_AccountDao accountDao; 
	
	public TH_AccountFactory(DAO_AccountDao accountDao){
		this.accountDao = accountDao;
	}
	
	public TH_AccountFactory(){
		this(new DAO_AccountDao());
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
		return this.create(name, phone, numberOfEmployees, false);
	}    

	public Account create (String name) {
		return this.create(name, null, null, false);
	}    
}