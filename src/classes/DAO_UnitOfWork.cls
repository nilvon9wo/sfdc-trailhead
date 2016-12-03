public class DAO_UnitOfWork {
	fflib_SObjectUnitOfWork unitOfWork;

	public DAO_UnitOfWork(fflib_SObjectUnitOfWork unitOfWork){
		this.unitOfWork = unitOfWork;
	} 

	public void register(SObject sObj){
		if (sObj.id != null){
			unitOfWork.registerDirty(sObj);
		}
		else {
			unitOfWork.registerNew(sObj);
		}
	}	
}