public with sharing class ExpireAdoption_BatchSchedule implements Schedulable {

    public void execute(SchedulableContext sc) {
        ExpireAdoptions_Batch b = new ExpireAdoptions_Batch(); 
        database.executebatch(b);
   }

}