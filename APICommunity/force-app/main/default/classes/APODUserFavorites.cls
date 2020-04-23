public class APODUserFavorites {
    @AuraEnabled
    public static void pushFavorites(String favorites, Id userId) {
        User user = [SELECT Favorite_APODs__c FROM User WHERE Id =: userId LIMIT 1];
        user.Favorite_APODs__c = favorites;
        update user;
    }
    @AuraEnabled
    public static String pullFavorites(Id userId) {
        return [SELECT Favorite_APODs__c FROM User WHERE Id =: userId LIMIT 1].Favorite_APODs__c;
    }
}
