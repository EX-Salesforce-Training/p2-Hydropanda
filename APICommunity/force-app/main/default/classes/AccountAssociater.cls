public class AccountAssociater {
    public static void associateAccounts(List<Account> accs) {
        List<Contact> conts = new List<Contact>();
        for (Account acc: accs) {
            Contact c = [SELECT Id FROM Contact WHERE Phone =: acc.Phone OR (MailingStreet =: acc.BillingStreet AND MailingCity =: acc.BillingCity) LIMIT 1];
            if (c != null) {
                c.AccountId = acc.Id;
                conts.add(c);
            }
        }
        if (!conts.isEmpty())
            update conts;
    }
}
