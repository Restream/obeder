(function () {
  const menuForm = $('#menu-form__form');
  const publishBtn = $('#menu-publish__btn');
  const validationModal = $('#menu-validation__modal');
  const validationSubmitBtn = $('#menu-validation__submit-btn');

  const validationUrl = validationModal.attr('validationUrl');

  const validationMarkers = {
    inProgress: $('#menu-validation__marker__in-validation'),
    ok: $('#menu-validation__marker__ok'),
    failed: $('#menu-validation__marker__failed'),
  };

  const validationErrorsList = $('#menu-validation__errors-list');

  menuForm.change(() => {
    publishBtn.prop('disabled', true);
  });

  validationModal.on('show.bs.modal', () => {
    validationMarkers.inProgress.show();
    validationMarkers.ok.hide();
    validationMarkers.failed.hide();
  });

  validationModal.on('hide.bs.modal', () => {
    validationSubmitBtn.prop('disabled', true);
    validationErrorsList.empty();
  });

  menuForm
    .on('cocoon:after-insert', () => {
      publishBtn.prop('disabled', true);
    })
    .on('cocoon:after-remove', () => {
      publishBtn.prop('disabled', true);
    });

  publishBtn.click(() => {
    $.get(validationUrl, (data) => {
      validationMarkers.inProgress.hide();

      if (!data.valid) {
        validationMarkers.failed.show();
        const errors = $.map(data.errors, error => $('<li></li>').text(error));
        validationErrorsList.html(errors);
        validationSubmitBtn.prop('disabled', true);
      } else {
        validationMarkers.ok.show();
        validationSubmitBtn.prop('disabled', false);
      }
    });
  });
}());
