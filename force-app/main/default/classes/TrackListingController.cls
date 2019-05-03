global with sharing class TrackListingController {

    @AuraEnabled
    global static List<Track__c> fetchPlaylistTracks(String playlistId){
        List<Track__c> trackData = new List<Track__c>();
        List<Track> spotifyTrackList = SpotifyService.getPlaylistTracks(playlistId);
        for(Track t : spotifyTrackList){
            Track__c newTrack = new Track__c();
            newTrack.artist__c = t.artists.get(0).name;
            newTrack.Name = t.name;

            String duration_s = String.valueOf(t.duration_ms / 1000);
            newTrack.duration__c = duration_s;
            
            newTrack.id__c = t.id;
            newTrack.spotifyUrl__c = t.href;

            //Generate search string for beatport
            String wordsQueryParams = '';
            String[] wordsInName = t.name.split(' ');
            for(String s : wordsInName){
                wordsQueryParams = wordsQueryParams + s + '+';
            }
            String searchString = 'https://www.beatport.com/search?q=' + wordsQueryParams;

            newTrack.beatportSearch__c = searchString;  
            trackData.add(newTrack);
        }
        return trackData;
    }
}
