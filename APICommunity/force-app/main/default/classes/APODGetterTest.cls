@isTest
public class APODGetterTest {
    @TestSetup
    public static void testSetup() {
        Test.setMock(HttpCalloutMock.class, new APODHttpCalloutMock());
    }
    @isTest
    public static void scheduledTest() {
        // Positive, APOD inserted
        Test.startTest();
        DailyAPODGet schedule = new DailyAPODGet();
        System.schedule('Daily APOD Cache', '0 0 4 ? * * *', schedule);
        Test.stopTest();

        
    }
    @isTest
    public static void browserTest() {
        // Get Today's Positive (Today's present)

        // Get Today's Negative (Today's not present, gets yesterday's)

        // Positive, APOD cached

        // Positive, APOD not cached, makes callout

        // Negative, APOD not cached, callout fails, async callout queued

    }
    @isTest
    public static void asyncTest() {
        // Positive, APOD inserted successfully

        // Negative, APOD not inserted, async callout queued

    }
}
