$(function(){

  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('value'));
  $('#new_subscription').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('input[type="submit"]').prop('disabled', true);

    Stripe.card.createToken($form, stripeResponseHandler);
    // Prevent the form from submitting with the default action
    return false;
  });
});

var stripeResponseHandler = function(status, response) {
  var $form = $('#new_subscription');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('input[type="submit"]').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and submit
    $form.get(0).submit();
  }
};