public class AutoConvertMagazineLead {
    @InvocableMethod
    public static void leadConvert(List<Id> leadIds) {
        LeadStatus ls = [SELECT MasterLabel FROM LeadStatus WHERE isConverted=true LIMIT 1];
        List<Database.LeadConvert> lcs = new List<Database.LeadConvert>();
        for (Id currentId: leadIds) {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(currentId);
            lc.setConvertedStatus(ls.MasterLabel);
            lc.setDoNotCreateOpportunity(true);
            lcs.add(lc);
        }
        if (!lcs.isEmpty())
            Database.convertLead(lcs);
    }
}
