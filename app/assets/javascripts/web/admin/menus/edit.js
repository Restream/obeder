(function() {
  var menuForm = $('#menu-form__form');
  var publishBtn = $('#menu-publish__btn');
  var validationModal = $('#menu-validation__modal');
  var validationSubmitBtn = $('#menu-validation__submit-btn');

  var validationUrl = validationModal.attr('validationUrl');

  var validationMarkers = {
    inProgress: $('#menu-validation__marker__in-validation'),
    ok: $('#menu-validation__marker__ok'),
    failed: $('#menu-validation__marker__failed')
  };

  var validationErrorsList = $('#menu-validation__errors-list');

  menuForm.change(function(e) {
    publishBtn.prop('disabled', true);
  });

  validationModal.on('show.bs.modal', function (e) {
    validationMarkers.inProgress.show();
    validationMarkers.ok.hide();
    validationMarkers.failed.hide();
  });

  validationModal.on('hide.bs.modal', function (e) {
    validationSubmitBtn.prop('disabled', true);
    validationErrorsList.empty();
  });

  publishBtn.click(function(e) {
    $.get(validationUrl, function(data) {
      validationMarkers.inProgress.hide();

      if (!data.valid) {
        validationMarkers.failed.show();
        var errors = $.map(data.errors, function(error, i) {
          return $('<li></li>').text(error);
        });
        validationErrorsList.html(errors);
      } else {
        validationMarkers.ok.show();
      }

      validationSubmitBtn.prop('disabled', false);
    });
  });
})();
