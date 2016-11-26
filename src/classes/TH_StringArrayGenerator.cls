public class TH_StringArrayGenerator {
	public static List<String> generateStringArray(Integer quantity) {
		List<String> resultList = new List<String>();
		for (Integer i = 0; i <= quantity - 1; i++){
			resultList.add('Test ' + i);
		} 
		return resultList;
	}
}