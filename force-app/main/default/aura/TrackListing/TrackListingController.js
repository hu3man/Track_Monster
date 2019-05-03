({
    tableInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Track Name', fieldName: 'Name', type: 'text'},
            {label: 'Artist', fieldName: 'artist__c', type: 'text'},
            {label: 'Duration', fieldName: 'duration__c', type: 'text'},
            {label: 'Listen on Spotify', fieldName: 'spotifyUrl__c', type: 'url '},
            {label: 'Search on Beatport', fieldName: 'beatportSearch__c', type: 'url'}
            ]);
    }
})