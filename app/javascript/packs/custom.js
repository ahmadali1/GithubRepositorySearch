function performSearch(){
  document.querySelector("#search-form").requestSubmit();
}

// TODO: Refactor to either infinite scroll or bind click with .page-link
$(document).on('turbolinks:load', function () {
  $(document).on('click', '#next-page', () => {
    $('#page').val(parseInt($('#page').val()) + 1);
    performSearch();
  });

  $(document).on('click', '#previous-page', () => {
    $('#page').val(parseInt($('#page').val()) - 1);
    performSearch();
  });

  $( "#search-form" ).submit(function( event ) {
    $('#loader').removeClass('d-none');
  });
});
