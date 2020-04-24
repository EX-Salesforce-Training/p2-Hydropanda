public class DailyAPODGet implements Schedulable {
    public void execute(SchedulableContext sc) {
        System.enqueueJob(new APODGetterAsync(Date.today()));
    }
}