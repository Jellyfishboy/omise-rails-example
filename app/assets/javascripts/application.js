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
//= require turbolinks
//= require_tree .

$(document).ready(function()
{
    Omise.setPublicKey('pkey_test_52r47ggdjaduxx1emu1');

    $('body').on('submit', '#new_card', function()
    {
        var $form = $(this),
            userId = $form.attr('data-user-id');

        var $inputs = $('#new_card :input');

        var card = {};
        $inputs.each(function() {
            card[this.name] = $(this).val();
        });

        Omise.createToken("card", card, function (statusCode, response) {
            if (statusCode == 200) {
                $.ajax(
                {
                    url: '/users/' + userId + '/omise_cards',
                    type: 'POST',
                    data: { token: response.id },
                    dataType: 'json',
                    success: function (data)
                    {
                        $('#cards-container p').remove();
                        $('#cards').append(data.card);
                        $form[0].reset();
                    }
                });
            } else {
                alert(response.message);
            };
        }); 
        
        return false;
    });
});