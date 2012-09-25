function fixLogo(){
	_w=$("slide").width();
	_h=$("slide").height();
	$("slide").css("background", "white url(img/cms_logo.png) " + (_w - 235) + "px " + (_h - 35) + "px no-repeat");	
}

$(function(){
	fixLogo();
	$(window).resize(fixLogo);
});
