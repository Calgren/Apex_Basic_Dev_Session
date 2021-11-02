@IsTest
public with sharing class AdoptionTriggerHelper_Test {

    @TestSetup
    private static void doSetup(){

    }

    /**
     * @description 
     */
    @IsTest
    private static void getExistingAdoptionsTest() {
        Date startDate = Date.today();
        Date endDate = Date.today().addMonths(1);
        Account testAcc1 = new Account(Name = 'Test Acc1');
        Account testAcc2 = new Account(Name = 'Test Acc2');
        insert new List<Account>{testAcc1, testAcc2};
        Animal__c testAnim1 = new Animal__c(Name = 'Test anim1');
        Animal__c testAnim2 = new Animal__c(Name = 'Test anim2');
        insert new List<Animal__c>{testAnim1, testAnim2};
        Adoption__c testAdop1 = new Adoption__c(Account__c = testAcc1.Id, Animal__c = testAnim1.Id, Status__c = 'Active', Start_Date__c = startDate, End_Date__c = endDate);
        Adoption__c testAdopt2 = new Adoption__c(Account__c = testAcc2.Id, Animal__c = testAnim2.Id, Status__c = 'Expired', Start_Date__c = startDate, End_Date__c = endDate);
        insert new List<Adoption__c>{testAdop1, testAdopt2};
        List<Adoption__c> newList = new List<Adoption__c> {
            new Adoption__c(Account__c = testAcc1.Id, Animal__c = testAnim1.Id, Start_Date__c = startDate, End_Date__c = endDate, Status__c = 'Active'),
            new Adoption__c(Account__c = testAcc2.Id, Animal__c = testAnim2.Id, Start_Date__c = startDate, End_Date__c = endDate, Status__c = 'Active')
        };
        //Prepare data
        Test.startTest();
        // call the tested logic
        List<Adoption__c> result = AdoptionTriggerHelper.getExistingAdoptions(newList);
        Test.stopTest();

        // do the asserts to verify result
        System.assertEquals(3, result.size());
        for (Adoption__c adop : result) {
            System.assertNotEquals('Expired', adop.Status__c);
        }
        System.assertEquals(testAdop1.Id, result[0].Id);
    }



    @IsTest
    private static void testExceptionThrown() {
        try {
            //Prepare data
            Test.stopTest();
            // call the tested logic
            System.assert(false, 'Exception should be thrown');
        } catch (Exception e) {
            System.assertEquals(Exceptions.DMLException.class, e.class);
        } finally {
            Test.stopTest();
        }
    }
}