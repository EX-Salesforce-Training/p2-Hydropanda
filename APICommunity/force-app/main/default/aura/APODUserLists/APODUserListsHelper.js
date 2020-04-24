({
    updateFavorites : function(component, favorite) {
        var favorites = favorite.join(", ");
        var method = component.get("c.pushFavorites");
        method.setParams({"favorites" : favorites, "userId" : $A.get("$SObjectType.CurrentUser.Id")});
        method.setCallback(this, function(response) {
            component.set("v.favorite", favorite);
        });
        $A.enqueueAction(method);
    }, 
    favorite : function(component, date) {
        var favorite = component.get("v.favorite");
        var inserted = false; 
        if (favorite.length == 0 || date < favorite[favorite.length-1]) {
            favorite.push(date);
            inserted = true;
        }
        var i = 0;
        while (!inserted && i < favorite.length) {
            if (date > favorite[i]) {
                favorite.splice(i, 0, date);
                inserted = true;
            }
            i++;
        }
        console.log(favorite);
        this.updateFavorites(component, favorite);
    },
    unfavorite : function(component, date) {
        var favorite = component.get("v.favorite");
        var deleted = false; var i = 0;
        while (!deleted && i < favorite.length) {
            if (date === favorite[i]) {
                favorite.splice(i, 1);
            }
            i++;
        }
        this.updateFavorites(component, favorite);
    },
    isFavorite : function(component, date) {
        var favorite = component.get("v.favorite");
        var event = component.getEvent("isFav");
        var isFav = false; var i = 0;
        while (!isFav && i < favorite.length)
            isFav = (date === favorite[i++]);
        event.setParam("favorite", isFav);
        event.fire();
    }
})
