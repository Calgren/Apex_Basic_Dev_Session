public with sharing class ExpireAdoptions_Batch implements Database.Batchable<SObject>{
    private static final String ADOPTION_EXPIRED_STATUS = 'Expired';
    private static final String retrieveAdoptionsQuery = 'SELECT Id, Status__c, Start_Date__c, End_Date__c FROM Adoption__c' +
    ' WHERE (End_Date__c <= YESTERDAY OR End_Date__c = NEXT_N_DAYS:10 ) AND Status__c = \'Active\'';


    /**
     * @description 
     *
     * @param BC 
     * @return  `Database.QueryLocator`
     */
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(retrieveAdoptionsQuery);
    }


    public void execute(Database.BatchableContext BC, List<Adoption__c> scope) {
        try {
            List<Adoption__c> adopsToUpdate = new List<Adoption__c>();
            for (Adoption__c adop : scope) {
                if (adop.End_Date__c == Date.today() - 1) {
                    adop.Status__c = ADOPTION_EXPIRED_STATUS;
                    adopsToUpdate.add(adop);
                } else {
                    // CALL SENDING EMAIL;
                }
            }
            update adopsToUpdate;
        } catch(Exception e) {
            //TODO LOG exception
        }
        
    }

   public void finish(Database.BatchableContext BC) {
       // NOTHING TO DO HERE
   }

}