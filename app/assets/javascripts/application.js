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

// Select2 (vendor/assets/select2/)
//
//= require select2.js

//= require_tree .


function guidGenerator() {
    var S4 = function() {
       return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    };
    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}

String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g,"");
}
String.prototype.ltrim = function() {
    return this.replace(/^\s+/,"");
}
String.prototype.rtrim = function() {
    return this.replace(/\s+$/,"");
}


$(document).ready(function() {

   $(".alert-message").alert();

    var sanatize = /[^A-Za-z0-9\s]/g;

   $('#tags_list').select2({
    minimumInputLength: 2,
    tags: [],
    createSearchChoice: function(term) {
        return {name: term.replace(sanatize, '').ltrim().rtrim(), id: term.replace(sanatize, '').ltrim().rtrim()};
    },
    ajax: {
        url: tag_list_url,
        dataType: 'json',
        data: function(term, page) {
            return {
                q: term
            }
        },
        results: function(data, page) {
            $.each(data, function(index, item) {
                item.id = item.name;
            });
            return {results: data};
        }
    },
    formatResult: function(object) {
        return object.name;
    },
    formatSelection: function(object) {
        return object.name;
    }
   });

});
