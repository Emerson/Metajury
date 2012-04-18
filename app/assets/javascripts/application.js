// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

// jQUERY & jQuery-UI
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui

// BOOTSTRAP 2.0 (vendor/assets/bootstrap-2.0)
//
//= require js/bootstrap.js
//= require js/bootstrap-alert.js
//= require js/bootstrap-button.js
//= require js/bootstrap-carousel.js
//= require js/bootstrap-dropdown.js
//= require js/bootstrap-modal.js
//= require js/bootstrap-modal.js
//= require js/bootstrap-popover.js
//= require js/bootstrap-scrollspy.js
//= require js/bootstrap-tab.js
//= require js/bootstrap-tooltip.js
//= require js/bootstrap-typeahead.js

// JQUERY-TEXTEXT (vendor/assets/jquery-textext/)
//
//= require js/textext.core.js
//= require js/textext.plugin.autocomplete.js
//= require js/textext.plugin.prompt.js
//= require js/textext.plugin.tags.js
//= require js/textext.plugin.ajax.js

//= require_tree .



$(document).ready(function() {

   $(".alert-message").alert();

   $('#tags_list').textext({
   	plugins: 'tags prompt autocomplete ajax',
   	ajax: {
   		url: tag_list_url,
   		dataType: 'json',
   		results: function(query) {
   			console.log(query);
   		}
   	},
   	autocomplete: {
   		render: function(suggestion) {
   			return suggestion.name;
   		}
   	},
   	ext: {
	    itemManager: {
	        stringToItem: function(str) {
	            return { name: str };
	        },
	        itemToString: function(item) {
	            return item.name;
	    	},
	    	compareItems: function(item1, item2) {
	        return item1.name == item2.name;
	    	}
		}
    },
   	prompt: 'Add a tag...'
   });

});
