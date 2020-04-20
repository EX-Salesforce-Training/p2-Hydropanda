public class APODGetter {
    @AuraEnabled
    public static APOD__c getTodayAPOD() {
        return [SELECT Name, Date__c, Description__c, Copyright__c, URL__c, HD_URL__c FROM APOD__c ORDER BY Date__c DESC LIMIT 1];
    }
    @AuraEnabled
    public static APOD__c getAPOD(Date targetDate) {
        APOD__c apod = [SELECT Name, Date__c, Description__c, Copyright__c, URL__c, HD_URL__c FROM APOD__c WHERE Date__c =: targetDate LIMIT 1];
        if (apod == null)
            apod = cacheNewAPOD(targetDate);
        return apod;
    }
    public static APOD__c cacheNewAPOD(Date targetDate) {
        String apiURL = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&hd=true&date='
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
                if (!Test.isRunningTest())
                    System.enqueueJob(new APODGetterAsync(targetDate));
        } else {
            Map<String, Object> attrs = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            apod = new APOD__c(Name = (String) attrs.get('title'), Date__c = targetDate, Copyright__c = (String) attrs.get('copyright'),
            Description__c = (String) attrs.get('explanation'), URL__c = (String) attrs.get('url'), HD_URL__c = (String) attrs.get('hdurl'));
            insert apod;
        }
        return apod;
    }
}