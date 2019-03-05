public with sharing class DmlClass implements DmlInterface {
    
    public Boolean updateSObj(List<Sobject> sObjects) {
        List<Database.SaveResult> results = Database.update(sObjects);
    
        for (Database.SaveResult r : results) {
            if (!r.isSuccess()) {
                return false;
            }
        }
        return true;
    }
}