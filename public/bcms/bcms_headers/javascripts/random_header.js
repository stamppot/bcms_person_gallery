function random_person(page_id, personClass, time) {
	var urlString = "/random_persons/show/" + page_id.toString();
	jQuery(personClass).everyTime(time,function(i){
		jQuery(personClass).animate({opacity: 0.5}, "slow");
		jQuery.ajax({
			url: urlString,
			cache: false,
			success: function(person_string){
				jQuery(personClass).attr("src", person_string);
				jQuery(personClass).animate({opacity : 1.0}, "slow");
				}});
			});
		};