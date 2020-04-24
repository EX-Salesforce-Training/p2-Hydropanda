({
    checkUrl : function(component, event, helper) {
        var url = component.get("v.url");
        url = url.slice(-3);
        component.set("v.isImg", url === "jpg" || url === "gif");
    }
})
