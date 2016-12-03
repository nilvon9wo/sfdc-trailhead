public class TH_AnimalLocator { 
	public static String  getAnimalNameById(Integer animalId) {
		TH_AnimalLocator locator = new TH_AnimalLocator();
		return locator.getNameById(animalId);
	}

    public String getNameById(Integer animalId) {
		TH_AnimalLocatorStrategy callout = new TH_AnimalLocatorStrategy(); 
		callout.targetId = animalId;
		callout.execute();
		return callout.animal.name;  
    }   
}