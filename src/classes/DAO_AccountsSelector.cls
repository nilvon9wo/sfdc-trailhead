public class DAO_AccountsSelector {

	public virtual List<Account> selectAllAccountList() {
		return [ SELECT name, phone FROM Account ];
	}
	
	public virtual List<Account> selectByExactName (String accountName) {
		return [ 
			SELECT id, name,
				(SELECT firstName, lastName FROM Contacts) 
			FROM Account 
			WHERE name = :accountName 
		];
	}

	public virtual List<Account> selectByNameLikeness (String nameLikeness) {
		return [ SELECT id FROM Account WHERE name LIKE :nameLikeness ];
	}

	public virtual List<Account> selectAccountListById (List<Id> accountIdList) {
		return [ SELECT id FROM Account WHERE id IN :accountIdList ];
	}
	
    
}