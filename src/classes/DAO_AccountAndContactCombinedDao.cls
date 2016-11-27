public class DAO_AccountAndContactCombinedDao {
	public List<List<SObject>> find(String name){
		return [
			FIND :name
			IN ALL FIELDS
			RETURNING Account(name), Contact(firstName, lastName, department)
		];
	}    
}