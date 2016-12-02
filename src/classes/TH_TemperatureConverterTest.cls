@isTest
private class TH_TemperatureConverterTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
	@isTest static void testStaticC2fShouldConvertCorrectly(){
		// Arrange
		Decimal testInput = 70;
		
		// Act
		Decimal result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_TemperatureConverter.FahrenheitToCelcius(testInput);
            }
            Test.stopTest();
        }

		// Assert
		Decimal expectedCelcius = 21.11;
		System.assertEquals(expectedCelcius, result, 'Expected temperature was ' + expectedCelcius + ' but was ' + result);
	}
	
	@isTest static void c2fShouldConvert70FahrenheitCorrectly(){
		testC2f(70, 21.11);
	}
	@isTest static void c2fShouldConvert32FahrenheitCorrectly(){
		testC2f(32, 0);
	}
	
	@isTest static void c2fShouldConvert212FahrenheitCorrectly(){
		testC2f(212, 100);
	}
	
	@isTest static void c2fShouldConvertNeg10FahrenheitCorrectly(){
		testC2f(-10, -23.33);
	}
	
	private static void testC2f(Decimal fahrenheit, Decimal expectedCelcius){
		// Arrange
		TH_TemperatureConverter converterUnderTest = new TH_TemperatureConverter();
		
		// Act
		Decimal result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = converterUnderTest.f2c(fahrenheit);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(expectedCelcius, result, 'Expected temperature was ' + expectedCelcius + ' but was ' + result);
	}
}