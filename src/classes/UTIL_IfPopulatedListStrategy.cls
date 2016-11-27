public abstract class UTIL_IfPopulatedListStrategy { 
	public void execute(List<Object> listToCheck) { 
		if (listToCheck == null || listToCheck.size() == 0) {
			doIfEmpty();
		}
		else {
			doIfPopulated(listToCheck);
		}
	}    

	abstract void doIfPopulated(List<Object> listToCheck); 	
	abstract void doIfEmpty();
}