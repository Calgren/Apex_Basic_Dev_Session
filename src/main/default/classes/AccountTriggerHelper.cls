public with sharing class AccountTriggerHelper {

    private static final Integer PICTURE_SIZE = 150;
    
    public static void generateCard(List<Account> newList) {
        for (Account acc : newList) {
            System.enqueueJob(new GenerateQrCode_Queueable(PICTURE_SIZE, acc));
        }
    }
}