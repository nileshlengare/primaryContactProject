trigger updatePhoneNumber on Contact (before insert,before update,after insert,after update) {
    if(trigger.isBefore && trigger.isInsert){
        updatePhoneNumberTriggerHandler.preventCreatePrimaryContactOnAccout(trigger.new);
    }
    if(trigger.isBefore && trigger.isUpdate){
        updatePhoneNumberTriggerHandler.preventCreatePrimaryContactOnAccoutUpdate(trigger.newMap,trigger.oldMap);
    }
}