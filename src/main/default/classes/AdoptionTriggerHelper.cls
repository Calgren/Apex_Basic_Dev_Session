/**
 * @description Helper Class for AdoptionTrigger, contains methods for handling logic around Adoption__c
 *
 * @author BearingPoint 
 * @since 2021-10-27
 */
public with sharing class AdoptionTriggerHelper {
    private static final String ADOPTION_ACTIVE_STATUS = 'Active';

    /**
     * @description 
     *
     * @param newList 
     */
    public static void checkTheDuplicates(List<Adoption__c> newList) {
        Map<Id, List<Adoption__c>> activeAdoptionsByAccontId = new Map<Id, List<Adoption__c>>();
        Set<Id> newListAdoptionIds = new Set<Id>();
        Set<Id> relatedAnimals = new Set<Id>();
        Set<Id> relatedAccounts = new Set<Id>();
        for (Adoption__c adop : newList) {
            relatedAnimals.add(adop.Animal__c);
            relatedAccounts.add(adop.Account__c);
            newListAdoptionIds.add(adop.Id);
        }
        
        List<Adoption__c> existingAdoptions = [SELECT Id FROM Adoption__c 
        WHERE ID NOT IN :newListAdoptionIds AND Status__c = :ADOPTION_ACTIVE_STATUS AND (Account__c IN :relatedAccounts OR Animal__c IN :relatedAnimals)];

        List<Adoption__c> allAdoptions = new List<Adoption__c>();
        allAdoptions.addAll(existingAdoptions);
        allAdoptions.addAll(newList);

        for (Adoption__c adop : allAdoptions) {
            if (adop.Status__c.equals(ADOPTION_ACTIVE_STATUS)) {
                if (!activeAdoptionsByAccontId.containsKey(adop.Account__c)) {
                    activeAdoptionsByAccontId.put(adop.Account__c, new List<Adoption__c>());
                }
                activeAdoptionsByAccontId.get(adop.Account__c).add(adop);
            }
        }

        for (Id accId : activeAdoptionsByAccontId.keySet()) {
            List<Adoption__c> adoptionsToAcc = activeAdoptionsByAccontId.get(accId);
            Set<Id> alreadyContainedAnimal = new Set<Id>();
            for (Adoption__c adop : adoptionsToAcc) {
                if (alreadyContainedAnimal.contains(adop.Animal__c)) {
                    adop.addError('There is already exisitng adoption to the same account and animal.');
                } else {
                    alreadyContainedAnimal.add(adop.Animal__c);
                }
            }
        }
    }
}