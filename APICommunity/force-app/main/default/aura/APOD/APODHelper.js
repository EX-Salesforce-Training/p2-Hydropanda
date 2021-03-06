({
    APODCallout : function(component, method, targetDate) {
        if (targetDate)
            method.setParam("targetDate", targetDate);
        method.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS")
                if (response.getReturnValue()) {
                    component.set("v.apod", response.getReturnValue());
                    component.set("v.id", response.getReturnValue().Id);
                } else alert("Unfortunately the image you are looking for is currently unavailable. Please try again later.");
        });
        $A.enqueueAction(method);
    }, 
    getTodayAPOD : function(component) {
        var method = component.get("c.getTodayAPOD");
        this.APODCallout(component, method);
    }, 
    getAPODDate : function(component, targetDate) {
        var method = component.get("c.getAPODDate");
        this.APODCallout(component, method, targetDate);
    },
    getNextAPOD : function(component, targetDate) {
        var method = component.get("c.getNextAPODDate");
        this.APODCallout(component, method, targetDate);
    },
    getPreviousAPOD : function(component, targetDate) {
        var method = component.get("c.getPreviousAPODDate")
        this.APODCallout(component, method, targetDate);
    },
    getRandomAPOD : function(component) {
        var method = component.get("c.getAPODDate");
        var start = new Date("1995-6-16");
        var end = new Date();
        var randomDate = new Date(start.getTime() + (Math.random()*(end.getTime() - start.getTime())));
        var randomDateString = randomDate.getFullYear() + "-" + randomDate.getMonth() + "-" + randomDate.getDay();
        this.APODCallout(component, method, randomDateString);
    }
})
