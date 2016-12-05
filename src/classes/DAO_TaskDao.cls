public class DAO_TaskDao {
	public virtual UTIL_ResultListWrapper doInsert(List<Task> taskList){
		return DAO_SObjectDMLHelper.doInsert(taskList);
	}
}