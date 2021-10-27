/**
 * @description Trigger for Adoption__c SObject
 *
 */
trigger AdoptionTrigger on Adoption__c (before delete, before insert, before update, after delete, after insert, after update, after undelete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            AdoptionTriggerHelper.checkTheDuplicates(Trigger.new);
        }
        when BEFORE_UPDATE {
            AdoptionTriggerHelper.checkTheDuplicates(Trigger.new);
        }
    }
}