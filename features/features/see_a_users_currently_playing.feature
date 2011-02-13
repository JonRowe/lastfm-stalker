Feature: See what a user is currently listening to
  So that I can identify that cool tune and expand my music tastes
  As a lastfm user
  I want to see the track someone is currently plaing

  Scenario: Now playing
    Given there is a last fm user "a_lfm_user" currently listening to "Trackname" by "Artist"
    When I run
      """
      lastfm-stalker --user a_lfm_user
      """
    Then the output should contain:
      """
      a_lfm_user is currently listening to 'Trackname' by 'Artist'
      """
