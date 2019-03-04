$( function() {
  if (document.getElementById('waypoint')) {
    var waypoint = new Waypoint({
      element: document.getElementById('waypoint'),
      offset: 500,
      handler: function() {
        $('.js-header').toggleClass('has-background');
      }
    });
  }

  $('.js-header-menu').click( function() {
    $('.js-nav').addClass('is-open');
    $('.js-main').bind('click', function() {
      $('.js-nav').removeClass('is-open');
      $('.js-main').unbind('click');
    });
  });

  if ( $('#calendar').length ) {
    $('#calendar').fullCalendar({
      events: '/events.json',
      //defaultView: 'listMonth'
    });
  }
});
