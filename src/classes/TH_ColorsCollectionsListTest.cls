@isTest
private class TH_ColorsCollectionsListTest {
    private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	private static testMethod void getMoreColorByGetMethodShouldReturnOrange(){
		// Arrange
		TH_ColorsCollectionsList apexList = new TH_ColorsCollectionsList();
		Integer firstElement = 0;
		
		// Act
		TH_Color result = null;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = apexList.getMoreColorByGetMethod(firstElement);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, TH_Color.ORANGE);
	}

		
	private static testMethod void getMoreColorByIndexShouldReturnOrange(){
		// Arrange
		TH_ColorsCollectionsList apexList = new TH_ColorsCollectionsList();
		Integer firstElement = 0;
		
		// Act
		TH_Color result = null;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = apexList.getMoreColorByIndex(firstElement);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(result, TH_Color.ORANGE);
	}
	
	private static testMethod void iterateOverColorListsShouldIterateOverPrimarys(){
		// Arrange
		TH_ColorsCollectionsList apexList = new TH_ColorsCollectionsList();
		ColorCollectorStrategy colorCollectorStrategy = new ColorCollectorStrategy();
		
		// Act
        System.runAs(TestRunner){
            Test.startTest();
            {
                apexList.iterateOverColorLists(colorCollectorStrategy);
            }
            Test.stopTest();
        }

		// Assert
		List<TH_Color> resultList = colorCollectorStrategy.resultList;
		System.assertEquals(resultList[0], TH_Color.RED);
		System.assertEquals(resultList[1], TH_Color.GREEN);
		System.assertEquals(resultList[2], TH_Color.BLUE);
	}
	
	private class ColorCollectorStrategy implements TH_ColorConsumerStrategyInterface {
		private List<TH_Color> resultList = new List<TH_Color>();

		public void execute(TH_Color color) {
			this.resultList.add(color);
		}
		
		private List<TH_Color> getResultList() {
			return resultList;
		}
	}
}