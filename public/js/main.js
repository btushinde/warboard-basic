


$(function() {
	$blocks = $('.blocks').isotope({
		animationOptions: {
		duration: 750,
		easing: 'linear',
		queue: false
	},
	animationEngine : 'jquery'
});


$('.blocks').find('li .corner').click(function(){
	toggleBlock($(this).parent().parent());
});


// Pusher.log = function(message) {
//   if (window.console && window.console.log) window.console.log(message);
// };

//Flash fallback logging - don't include this in production
WEB_SOCKET_DEBUG = true;

var pusher = new Pusher('1d429354391310d97281');
var channel = pusher.subscribe('test_channel');

channel.bind('notification', function(data) {
  console.log(data.id);

  toggleBlock($('.block:eq('+data.id+')').parent());


});





});


function toggleBlock(block){
	$o = block;
	$o.toggleClass('expanded');
	$blocks.isotope('reLayout');
	$('#graph').toggle();
}