public class DAO_ContactAndLeadCombinedDao {
	public List<List<SObject>> find(String name){
		return [
			FIND :name
			IN ALL FIELDS
			RETURNING Contact(firstName, lastName), Lead(firstName, lastName)
		];
	}    
}