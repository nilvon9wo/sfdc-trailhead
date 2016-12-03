public class TH_ParkLocator {
	public static List<String> country(String countryName) {
		TH_ParkLocator locator = new TH_ParkLocator();
		return locator.byCountry(countryName);
	}    

	public List<String> byCountry(String countryName) {
		TH_ParkService.ParksImplPort parkService = new TH_ParkService.ParksImplPort();
		return parkService.byCountry(countryName);
	}    
}