({
    doInit : function(component, event, helper) {
        var action = component.get("c.getPlaylistNames");

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set("v.playlistNames",response.getReturnValue());
            }
            else {
                alert('Error fetching Spotify data');
            }
        });
        $A.enqueueAction(action);
    
    }
})