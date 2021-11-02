trigger AccountTrigger on Account (before delete, before insert, before update, after delete, after insert, after update, after undelete) {

    switch on Trigger.operationType {
        when AFTER_INSERT {
            AccountTriggerHelper.generateCard(Trigger.new);
        }
    }
}