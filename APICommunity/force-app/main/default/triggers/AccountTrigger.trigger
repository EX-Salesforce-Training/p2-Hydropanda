trigger AccountTrigger on Account (after insert) {
    if (Trigger.isAfter && Trigger.isInsert)
        AccountAssociater.associateAccounts(Trigger.new);
}