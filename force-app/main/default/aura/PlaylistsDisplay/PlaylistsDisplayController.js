({
    doInit: function (component, event, helper) {
        var action = component.get("c.getPlaylists");

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set("v.playlists",response.getReturnValue());
            }
            else {
                alert('Error fetching Spotify data');
            }
        });
        $A.enqueueAction(action);
    }
})