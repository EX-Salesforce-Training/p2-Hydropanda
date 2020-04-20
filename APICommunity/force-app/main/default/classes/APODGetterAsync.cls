public class APODGetterAsync implements Queueable, Database.AllowsCallouts {
    Date targetDate {get; set;}
    public APODGetterAsync(Date targetDate) {
        this.targetDate = targetDate;
    }
    public void execute(QueueableContext qc) {
        System.debug('Earlier APOD cache failed. Retrying now...');
        APODGetter.cacheNewAPOD(targetDate);
    }
}
