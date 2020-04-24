({
    doInit : function(component, event, helper) {
        var method = component.get("c.pullFavorites");
        method.setParam("userId", $A.get("$SObjectType.CurrentUser.Id"));
        method.setCallback(this, function(response) {
            if (response.getReturnValue()) {
                var favorite = response.getReturnValue().split(", ");
                component.set("v.favorite", favorite);
            }
        });
        $A.enqueueAction(method);
    },
    onNavAway : function(component, event, helper) {
        var event2 = component.getEvent("nav");
        event2.setParam("button", event.target.getAttribute("data-date"));
        event2.fire();
    },
    onNav : function(component, event, helper) {
        var recent = component.get("v.recent");
        var date = component.get("v.date");
        var deleted = false; var i = 0;
        while (!deleted && i < recent.length) {
            if (date === recent[i]) {
                recent.splice(i, 1);
            }
            i++;
        }
        if (recent.length >= 10)
            recent.pop();
        recent.unshift(date);
        component.set("v.recent", recent);
        helper.isFavorite(component, date);
    },
    onFav : function(component, event, helper) {
        var args = event.getParam("arguments");
        var date = event.getParam("arguments")[1];
        if (args[0])
            helper.favorite(component, date);
        else helper.unfavorite(component, date);
    }
})
