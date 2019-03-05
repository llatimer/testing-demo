trigger ContactTrigger on Contact (after delete, after insert, after undelete, after update) {

    if (trigger.isInsert && trigger.isAfter) {
        ContactClass.rollupContactCount(trigger.newMap.values(), null);
    } else if (trigger.isUpdate && trigger.isAfter) {
        ContactClass.rollupContactCount(trigger.newMap.values(), trigger.oldMap);
    } else if (trigger.isDelete && trigger.isAfter) {
        ContactClass.rollupContactCount(trigger.oldMap.values(), null);
    } else if (trigger.isUnDelete) {
        ContactClass.rollupContactCount(trigger.newMap.values(), null);
    }
}