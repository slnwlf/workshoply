// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require bootstrap-sprockets
//= require bootstrap-select-1.10.0/bootstrap-select.min
//= require_tree .

/* Making titleize function for String */
String.prototype.capitalize = function() {
  return this.charAt(0).toUpperCase() + this.slice(1);
};
String.prototype.titleize = function() {
  var string_array = this.split(' ');
  string_array = string_array.map(function(str) {
    return str.capitalize();
  });

  return string_array.join(' ');
};
/**************************************/

$(function() {
  // city autocomplete
  var options = {
    types: ['(cities)'],
    componentRestrictions: {
      country: "us"
    }
  };
  if ($(".location-input")[0]) {
    var autocomplere = new google.maps.places.Autocomplete($(".location-input")[0], options);
  }

  // notice and error disappears in 10 seconds
  $(".notice-error-msg .alert").fadeTo(10000, 1000).fadeOut(1000, function() {
    $(this).alert('close');
  });

  $("button#signup-with-email, button#login-with-email").on("click", function() {
    $(this).addClass("hidden");
  });

  // facebook sharing
  var fbid, channelUrl;
  if (window.location.host == 'localhost:3000') {
    fbid = "1000870533350913";
  } else if (window.location.host == 'www.bigtalker.io') {
    fbid = "751608544991088";
  }
  FB.init({
    appId: fbid,
    channelUrl: '//' + window.location.host,
    status: true,
    cookie: true,
    xfbml: true,
    version: 'v2.6'
  });
  $(".fb-share").on("click", function() {
    FB.ui({
      method: 'share',
      display: 'popup',
      mobile_iframe: true,
      href: share_url,
      hashtag: "#bigtalker"
    }, function(response) {});
  });

  // google plus share
  $(".google-share, .linkedIn-share").on("click", function() {
    sharePopUpWindow($(this).attr("data-name"), share_url);
  });
});

function sharePopUpWindow(network, share_url) {
  var link = {
    "google": "https://plus.google.com/share?url=",
    "linkedIn": "https://www.linkedin.com/cws/share?url="
  };
  window.open(
    link[network] + share_url,
    'popupwindow',
    'width=500,height=400'
  );
}

function getJsonFromUrl() {
  var query = location.search.substr(1);
  var result = {};
  query.split("&").forEach(function(part) {
    var item = part.split("=");
    result[item[0]] = decodeURIComponent(item[1]).replace(/\+/g, " ");
  });
  return result;
}