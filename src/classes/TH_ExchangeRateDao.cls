public class TH_ExchangeRateDao {
	public void doInsert(List<ExchangeRate__c> exchangeRateList) {
		insert exchangeRateList;
	}
	
	public List<ExchangeRate__c> getRates() {
		return [ 
			SELECT createdDate
			FROM ExchangeRate__c
			WHERE baseCurrency__c IN :TH_ExchangeRateWebServiceWrapper.baseCurrencyList   
				AND forList__c = true  
			ORDER BY createdDate DESC
			LIMIT 1
		];
	}
	
	public List<ExchangeRate__c>  getTodaysRates() {
		return [ 
			SELECT id, baseCurrency__c, toCurrency__c, rate__c
			FROM ExchangeRate__c
			WHERE baseCurrency__c IN :TH_ExchangeRateWebServiceWrapper.baseCurrencyList   
				AND forList__c = true
				AND createdDate = TODAY  
		];
	}
}