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
//= require quill.min
//= require quill.global
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
  // Navbar toggle
  $(".mobile-navbar").hide();

  $(".navbar-toggle-btn").click(function() {
    $(".mobile-navbar").toggleClass("active");
  });

  // Profile page
  $(".main-posts__wrapper").show();

  $(".menu__items").click(function() {
    $(".menu__items").removeClass("active");
    $(this).addClass("active");

    $(".main-posts__wrapper").hide();
    $(".main-followers").hide();
    $(".main-following").hide();

    if ($(this).prop("id") == "posts") {
      $(".main-posts__wrapper").show();
    } else if ($(this).prop("id") == "followers") {
      $(".main-followers").show();
    } else if ($(this).prop("id") == "following") {
      $(".main-following").show();
    }
  });

  // Side toolbar for new article
  $(".side-toolbar__button").click(function() {
    $(".side-toolbar__button").toggleClass("active");
    $(".add-article-image").toggleClass("active");
    $(".ql-editor p").toggle();
  });

  // Category Modal
  $(".new-category .new-category__btn").click(function() {
    $("#create-new-category-modal").show();
    $(".category-modal-overlay").show();
  });

  $("#new-category-close").click(function() {
    $("#create-new-category-modal").hide();
    $(".category-modal-overlay").hide();
  });

  $(".edit-item-category .edit-category__btn").click(function() {
    $("#edit-category-modal").show();
    $(".category-modal-overlay").show();
  });

  $("#edit-category-close").click(function() {
    $("#edit-category-modal").hide();
    $(".category-modal-overlay").hide();
  });

  // Profile Modal
  $(".profile-info__content .edit-btn").click(function() {
    $("#update-profile-modal").show();
    $(".update-profile-modal-overlay").show();
  });

  $(".modal-close-button #btn-close").click(function() {
    $("#update-profile-modal").hide();
    $(".update-profile-modal-overlay").hide();
  });
});
