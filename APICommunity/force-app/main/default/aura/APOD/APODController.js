({
    doInit : function(component, event, helper) {
        helper.getTodayAPOD(component);
    }, 
    onNav : function(component, event, helper) {
        switch (event.getParam("button")) {
            case 'Random': helper.getRandomAPOD(component); break;
            case 'Previous': helper.getPreviousAPOD(component, component.get("v.apod").Date__c); break;
            case 'Next' : helper.getNextAPOD(component, component.get("v.apod").Date__c); break;
            case 'First' : helper.getAPODDate(component, "1995-06-16"); break;
            case 'Last' : helper.getTodayAPOD(component); break;
            default: helper.getAPODDate(component, event.getParam("button"));
        }
    },
    onFav : function(component, event, helper) {
        component.find("lists").onFav(event.getParam("favorited"), component.get("v.apod").Date__c);
    },
    isFav : function(component, event, helper) {
        component.set("v.favorite", event.getParam("favorite"));
    }
})
