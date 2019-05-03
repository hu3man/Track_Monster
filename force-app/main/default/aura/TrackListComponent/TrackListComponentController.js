({
    getTracks : function(component, event, helper) {
        var id = component.get("v.playlistId");

        var action = component.get("c.fetchPlaylistTracks")
        action.setParams({ playlistId: id
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.spotifyTracks", response.getReturnValue());
                component.set("v.dataIsLoaded", "true");
            }
        });
        $A.enqueueAction(action);
    }
})
