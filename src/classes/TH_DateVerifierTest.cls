@isTest
private class TH_DateVerifierTest {
	private static final User TestRunner = TEST_RunAsUserFactory.create(); 
	
 	@isTest static void checkDatesShouldReturnSecondDateWhenLessThan30DaysAndDateOneComesFirst(){
		Date dateOne = Date.today();
		Date dateTwo = dateOne.addDays(29);
 		testCheckDates(dateOne, dateTwo, dateTwo);
 	}

 	@isTest static void checkDatesShouldReturnSecondDateWhenLessThan30DaysAndDateOneComesSecond(){
		Date dateTwo = Date.today();
		Date dateOne = dateTwo.addDays(29);
 		testCheckDates(dateOne, dateTwo, dateOne);
 	}
 	
 	@isTest static void checkDatesShouldReturnEndOfMonthForDateOneWhen30DaysAndDateOneComesFirst(){
		Date dateOne = date.newInstance(1989, 4, 21);
		Date dateTwo = dateOne.addDays(30);
 		testCheckDates(dateOne, dateTwo, date.newInstance(1989, 4, 30));
 	}

 	@isTest static void checkDatesShouldReturnEndOfMonthForDateOneWhen30DaysAndDateOneComesSecond(){
		Date dateTwo = date.newInstance(1989, 4, 21);
		Date dateOne = dateTwo.addDays(30);
 		testCheckDates(dateOne, dateTwo, date.newInstance(1989, 5, 31));
 	}
 	
 	@isTest static void checkDatesShouldReturnEndOfMonthForDateOneWhenOver30DaysAndDateOneComesFirst(){
		Date dateOne = date.newInstance(1989, 4, 21);
		Date dateTwo = dateOne.addDays(31);
 		testCheckDates(dateOne, dateTwo, date.newInstance(1989, 4, 30));
 	}

 	@isTest static void checkDatesShouldReturnEndOfMonthForDateOneWhenOver30DaysAndDateOneComesSecond(){
		Date dateTwo = date.newInstance(1989, 4, 21);
		Date dateOne = dateTwo.addDays(31);
 		testCheckDates(dateOne, dateTwo, date.newInstance(1989, 5, 31));
 	}

 	private static void testCheckDates(Date dateOne, Date dateTwo, Date expectedDate){
		// Act
		Date result;
        System.runAs(TestRunner){
            Test.startTest();
            {
                result = TH_DateVerifier.checkDates(dateOne, dateTwo);
            }
            Test.stopTest();
        }

		// Assert
		System.assertEquals(expectedDate, result);
 	}
}