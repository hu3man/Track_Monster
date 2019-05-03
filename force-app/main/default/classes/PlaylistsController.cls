global with sharing class PlaylistsController {

    @AuraEnabled
    global static List<String> getPlaylistNames(){
        List<String> pNames = new List<String>();
        List<SpotifyPlaylist> pl = SpotifyService.getSpotifyPlaylists();

        for(SpotifyPlaylist sp : pl){
            pNames.add(sp.name);
        }
        return pNames;
    }

    @AuraEnabled
    global static List<Playlist__c> getPlaylists(){
        List<Playlist__c> playlists = new List<Playlist__c>();
        List<SpotifyPlaylist> spotifyData = SpotifyService.getSpotifyPlaylists();

        //Create custom playlist objects from SpotifyPlaylist apex objects
        for(SpotifyPlaylist sp : spotifyData){
            Playlist__c newPlaylist = new Playlist__c();
            newPlaylist.Name = sp.name;
            newPlaylist.Id__c = sp.id;
            newPlaylist.Collaborative__c = sp.isCollaborative;
            newPlaylist.numTracks__c = sp.numTracks;
            playlists.add(newPlaylist);
        }
        return playlists;
    }
}