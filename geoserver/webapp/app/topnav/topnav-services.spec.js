describe('Top Nav User Service', function() {

  beforeEach(module('gsApp.topnav.services'));

  it('should say joe schmoe',
     inject(['topNavService', function(topNavService) {
        var user = topNavService.fetchUser();
        expect(user).toEqual('Joe Schmoe!');
      }]));
});
