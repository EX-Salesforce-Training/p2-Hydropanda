({
    getTodayAPOD : function(component) {
        var method = component.get("c.getTodayAPOD");
        method.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.apod", response.getReturnValue());
                component.set("v.id", response.getReturnValue().Id);
            }
        });
        $A.enqueueAction(method);
    }
})
