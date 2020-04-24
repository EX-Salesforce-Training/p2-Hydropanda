@isTest
public with sharing class AccountAssociaterTest {
    @isTest
    public static void associateAccountsTest() {
        Contact c = new Contact(lastName='Bob', firstName='Jim');
        insert c;

        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact cd = [SELECT AccountId FROM Contact LIMIT 1];
        System.debug(acc);
        System.debug(cd);
        System.assertEquals(cd.AccountId, acc.Id);
    }
}
