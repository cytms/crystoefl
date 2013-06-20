//nav_bar_click_event.js
$('#nav_bar button.btn').click(function () {
	console.log('click nav');
	$.ajax({
		type : "GET", 
		url  : "/",
		dataType : 'html',
		data : { 'category': $(this).attr('value')},
		success : function(pager){
			$('#article_container div').remove();
			$('#article_container').append('<div pager="1">' + pager + '</div><div pager="2"></div>');
			console.log("render new page!")
		},
		error : function(){
			console.log('something wrong happened');
		}
	}).done(function(){
		console.log("ending");
	});
});