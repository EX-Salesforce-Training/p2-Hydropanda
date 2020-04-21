@isTest
public class APODGetterTest {
    @isTest
    public static void queuedTestPositive() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());

        // Positive, APOD inserted successfully
        Test.startTest();
        System.enqueueJob(new APODGetterAsync(Date.today()));
        Test.stopTest();

        APOD__c apod = [SELECT Copyright__c, Name, URL__c, HD_URL__c FROM APOD__c LIMIT 1];
        System.assertEquals('Miguel Claro', apod.Copyright__c);
        System.assertEquals('Eye on the Milky Way', apod.Name);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_960.jpg', apod.URL__c);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_1380.jpg', apod.HD_URL__c);
    }
    @isTest
    public static void queuedTestNegative() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());

        // Negative, APOD not inserted, async callout queued
        Test.startTest();
        System.enqueueJob(new APODGetterAsync(Date.newInstance(1995, 6, 16)));
        Test.stopTest();

        System.assert([SELECT Id FROM APOD__c].isEmpty());
    }
    @isTest
    public static void browserTestPositive() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());

        // Get Today's Positive (Today's present)
        // Positive, APOD cached

        Test.startTest();
        System.enqueueJob(new APODGetterAsync(Date.today()));
        System.enqueueJob(new APODGetterAsync(Date.newInstance(2000, 1, 1)));
        Test.stopTest();

        APOD__c today = APODGetter.getTodayAPOD();
        System.assertEquals('Miguel Claro', today.Copyright__c);
        System.assertEquals('Eye on the Milky Way', today.Name);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_960.jpg', today.URL__c);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/EyeOnMW_Claro_1380.jpg', today.HD_URL__c);

        APOD__c Y2K = APODGetter.getAPOD(Date.newInstance(2000, 1, 1));
        System.assertEquals('N/A', Y2K.Copyright__c);
        System.assertEquals('The Millennium that Defines Universe', Y2K.Name);
        System.assertEquals('https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor_big.gif', Y2K.URL__c);
        System.assertEquals('https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor.gif', Y2K.HD_URL__c);
    }
    @isTest
    public static void browserTestNotCachedPositive() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());

        // Positive, APOD not cached, makes callout
        Test.startTest();
        APOD__c Y2K = APODGetter.getAPOD(Date.newInstance(2000, 1, 1));
        Test.stopTest();

        System.assertEquals('N/A', Y2K.Copyright__c);
        System.assertEquals('The Millennium that Defines Universe', Y2K.Name);
        System.assertEquals('https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor_big.gif', Y2K.URL__c);
        System.assertEquals('https://apod.nasa.gov/apod/image/0001/flammarion_halfcolor.gif', Y2K.HD_URL__c);
    }
    @isTest
    public static void browserTestTodayNegative() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());

        // Get Today's Negative (Today's not present, gets yesterday's)

        Test.startTest();
        System.enqueueJob(new APODGetterAsync(Date.today().addDays(-1)));
        Test.stopTest();

        APOD__c yesterday = APODGetter.getTodayAPOD();
        System.assertEquals('Juan Filas', yesterday.Copyright__c);
        System.assertEquals('IC 2944: The Running Chicken Nebula', yesterday.Name);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/IC2944_Filas_960.jpg', yesterday.URL__c);
        System.assertEquals('https://apod.nasa.gov/apod/image/2004/IC2944_Filas_3320.jpg', yesterday.HD_URL__c);
    }
    @isTest
    public static void browserTest404Negative() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());
        
        // Negative, APOD not cached, callout fails, async callout queued

        Test.startTest();
        APOD__c unavailable = APODGetter.getAPOD(Date.newInstance(1995, 06, 16));
        Test.stopTest();

        System.assertEquals(null, unavailable);
    }
}
