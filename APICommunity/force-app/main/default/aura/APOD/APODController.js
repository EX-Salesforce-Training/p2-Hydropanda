({
    doInit : function(component, event, helper) {
        helper.getTodayAPOD(component);
    }, 
    onNavButton : function(component, event, helper) {
        switch (event.getParam("button")) {
            case 'Random': helper.getRandomAPOD(component); break;
            case 'Previous': helper.getPreviousAPOD(component, component.get("v.apod").Date__c); break;
            case 'Next' : helper.getNextAPOD(component, component.get("v.apod").Date__c); break;
            case 'First' : helper.getAPODDate(component, "1995-06-16"); break;
            case 'Last' : helper.getTodayAPOD(component); break;
            default: helper.getAPODDate(component, event.getParam("button"));
        }
        component.find("lists").onNav({"favorited" : event.getParam("favorited"), "date" : component.get("v.apod").Date__c});
    }
})
