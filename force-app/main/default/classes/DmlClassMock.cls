public with sharing class DmlClassMock implements DmlInterface {
    
    @TestVisible
	private Boolean rtnVal { get; private set; }

    public Boolean updateSObj(List<Sobject> sObjects) {
        return rtnVal;
    }
}