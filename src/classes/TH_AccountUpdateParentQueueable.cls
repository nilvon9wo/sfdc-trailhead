public class TH_AccountUpdateParentQueueable implements Queueable {
	private DAO_AccountDao accountDao;
    private List<Account> accountList;
    private Id parentId;
    
    public TH_AccountUpdateParentQueueable(List<Account> accountList, Id parentId, DAO_AccountDao accountDao){
    	this.accountList = accountList;
    	this.parentId = parentId;
    	this.accountDao = accountDao; 
    }
    
    public TH_AccountUpdateParentQueueable(List<Account> accountList, Id parentId){
    	this(accountList, parentId, new DAO_AccountDao()); 
    }
    
    public void execute(QueueableContext context) {
    	for (Account account: accountList){
    		account.parentId = parentId;
    	}
    	accountDao.doUpdate(accountList);
    }
    
}