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
//= require turbolinks
//= require_tree .
//= require jquery



$(document).on('turbolinks:load', (e) => {

  // Hide edit comment form to start
  $('.edit-comment.form').hide()
  // If edit button is pushed, show form
  $('.pop-button.edit-comment').click((e)=>{
    const id = $(e.target).attr("data-id");
    $(`#${id}-form`).toggle()
    $(`#${id}-info`).toggle()
  });

  // Hide new comment form to start
  $('.new-comment.reply').hide()
  // If new comment button is pushed, show form
  $('.reply-button').click((e) => {
    const id = $(e.target).attr("data-id");
    console.log(id);
    $(`.reply-${id}`).toggle()
  });


  // User searching
  // Hide results to start
  const $results = $('.results').hide()

  // When the user types in the search bar, do a search if there is text
  $('#q').on("keyup", (e) => {
    if ($(e.target).val().length) {
      $("#submit").click();
    } else {
      $results.empty()
    }
  })

  // Once the search comes back
  $(".search").on("ajax:success", (e) => {
    const users = JSON.parse(e.detail[2].response).users;
    $results.empty().hide()
    if (users.length){
      $results.show()
      users.forEach(user => {
        const $container = $('<a>', {
          href: `/users/${user.id}`,
          class: 'user'
        }).appendTo($results);
        const $img = $('<img>', {
          src: user.avatar
        }).appendTo($container)
        const $name = $('<p>').text(user.name).appendTo($container)
      })
    }
  });
});
