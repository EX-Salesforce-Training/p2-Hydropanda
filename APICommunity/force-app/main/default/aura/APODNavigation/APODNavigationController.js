({
    onNavButton : function(component, event, helper) {
        var event2 = component.getEvent("nav");
        if (event.getSource().getLocalId())
            event2.setParam("button", event.getSource().getLocalId());
        else event2.setParam("button", component.get("v.date"));
        event2.setParam("favorited", component.get("v.favorited"));
        event2.fire();
    },
    favorite : function(component, event, helper) {
        component.set("v.favorited", !component.get("v.favorited"));
    }, 
    checkBounds : function(component, event, helper) {
        var date = component.get("v.date");
        if (!component.get("v.today"))
            component.set("v.today", component.get("v.date"));
        else {
        var now = component.get("v.today");
        component.set("v.hasNext", date.substr(0,4) < now.substr(0,4) || date.substr(5,2) < now.substr(5,2) || date.substr(8,2) < now.substr(8,2));
        component.set("v.hasPrevious", date.substr(0,4) > 1995 || date.substr(5,2) > 6 || date.substr(8,2) > 16);
        }
    }
})
