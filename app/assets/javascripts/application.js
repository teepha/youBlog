// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).ready(function() {
  $(".form-group").hide();

  $(".fa-search").hover(function() {
    $(".form-group").show();
  });

  $(".main-posts").show();

  $(".menu__items").click(function() {
    $(".menu__items").removeClass("active");
    $(this).addClass("active");

    $(".main-posts").hide();
    $(".main-followers").hide();
    $(".main-following").hide();

    if ($(this).prop("id") == "posts") {
      $(".main-posts").show();
    } else if ($(this).prop("id") == "followers") {
      $(".main-followers").show();
    } else if ($(this).prop("id") == "following") {
      $(".main-following").show();
    }
  });
});
