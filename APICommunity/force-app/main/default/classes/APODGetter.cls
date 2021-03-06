public class APODGetter {
    @AuraEnabled
    public static APOD__c getTodayAPOD() {
        return [SELECT Name, Date__c, Description__c, Copyright__c, URL__c, HD_URL__c FROM APOD__c ORDER BY Date__c DESC LIMIT 1];
    }
    @AuraEnabled
    public static APOD__c getAPODDate(String targetDate) {
        return getAPOD(Date.valueOf(targetDate));
    }
    @AuraEnabled
    public static APOD__c getNextAPODDate(String targetDate){
        APOD__c apod; Integer days = 1;
        while (apod == null)
            apod = getAPOD(Date.valueOf(targetDate).addDays(days++));
        return apod;
    }
    @AuraEnabled
    public static APOD__c getPreviousAPODDate(String targetDate){
        APOD__c apod; Integer days = -1;
        while (apod == null)
            apod = getAPOD(Date.valueOf(targetDate).addDays(days--));
        return apod;
    }
    public static APOD__c getAPOD(Date targetDate) {
        List<APOD__c> apod = [SELECT Name, Date__c, Description__c, Copyright__c, URL__c, HD_URL__c FROM APOD__c WHERE Date__c =: targetDate LIMIT 1];
        if (apod.isEmpty())
            apod.add(cacheNewAPOD(targetDate));
        return apod[0];
    }
    public static APOD__c cacheNewAPOD(Date targetDate) {
        String apiURL = 'https://api.nasa.gov/planetary/apod?api_key=MFeiEds6aEkwOhAnDXgNPhyqmHfQO3ZgRnjBtyGS&hd=true&date='
            + targetDate.year() + '-' + targetDate.month() + '-' + targetDate.day();
        APOD__c apod;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiURL);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);

        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('APOD Cache failed: The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            Map<String, Object> attrs = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            if (!attrs.containsKey('copyright'))
                attrs.put('copyright', 'N/A');
            if (!attrs.containsKey('hdurl'))
                attrs.put('hdurl', attrs.get('url'));
            apod = new APOD__c(Name = (String) attrs.get('title'), Date__c = targetDate, Copyright__c = (String) attrs.get('copyright'),
                Description__c = (String) attrs.get('explanation'), URL__c = (String) attrs.get('url'), HD_URL__c = (String) attrs.get('hdurl'));
            insert apod;
        }
        return apod;
    }
}