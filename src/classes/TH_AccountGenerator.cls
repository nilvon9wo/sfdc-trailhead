public class TH_AccountGenerator {
	public Account create (String name) {
		return new Account(Name = name);
	}    

	public Account create (String name, String phone, Integer employeeCount) {
		Account account = this.create(name);
		account.phone = phone;
		account.numberOfEmployees = employeeCount;
		return account;
	}    
}