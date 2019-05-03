@isTest
public with sharing class SpotifyServiceTest {
    @isTest
    static void testUrlSuffix(){
        String testData = 'https://api.spotify.com/v1/me/playlists';
        String result = SpotifyService.getUrlSuffix(testData);
        System.assertEquals('me/playlists', result);
    }

//     @isTest 
//     static void testGetAllPlaylistsWithStaticResource(){
//         StaticResourceCalloutMock data = new StaticResourceCalloutMock();
//         data.setStaticResource(staticResourceName('GetPlaylistsMockJSON'));
//         data.setStatus(200);
//         data.setHeader('Content-Type', 'application/json');
    
//         Test.setMock(HttpCalloutMock.class, data);
//         HttpResponse res = SpotifyService.getSpotifyPlaylists();
//     }
    }