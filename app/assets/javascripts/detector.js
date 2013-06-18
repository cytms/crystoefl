/* detector.js */
$(document).scroll(function() {
	var $BodyHeight = $(document).height();
	var $ViewportHeight = $(window).height();
	console.log($BodyHeight);
	$ScrollTop=$(this).scrollTop();
	if($BodyHeight==($ViewportHeight+$ScrollTop)){  
		$.ajax({
			type : "GET", 
			url  : "/",
			dataType : 'html',
			data : { 'page': $('#article_container div:last').attr('pager')},
			success : function(pager){
				var $lastPage = $('#article_container div:last').attr('pager')
				$('#article_container div:last').html(pager);
				$('#article_container').append('<div pager="' + (parseInt($lastPage)+1) + '"></div>');
				var list = $('li:not(.todo-done)');
				for (var i = 0; i < list.length; i++) {
					var tmp = "." + list[i].id;
					console.log('---------------->' + list[i].id);
					$(tmp).fadeOut();
            		$(tmp).parent().css("border", "0px");
				}
			},
			error : function(){
				console.log('something wrong happened');
			}
		}).done(function(){
			console.log("ending");
		});
	};
});
