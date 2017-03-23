(function() {
  var publishBtn = $('#publish_btn');
  var publishModal = $('#publish_modal');
  var publishSubmitBtn = $('#publish_submit_btn')
  var validationUrl = publishModal.attr('validationUrl');

  var validationMarkers = {
    inProgress: $('#in_validation_marker'),
    ok: $('#validation_ok_marker'),
    failed: $('#validation_failed_marker')
  };

  var validationErrorsList = $('#validation_errors');

  publishModal.on('show.bs.modal', function (e) {
    validationMarkers.inProgress.show();
    validationMarkers.ok.hide();
    validationMarkers.failed.hide();
  });

  publishModal.on('hide.bs.modal', function (e) {
    publishSubmitBtn.prop('disabled', true);;
  });

  publishBtn.click(function(e) {
    $.get(validationUrl, function(data) {
      validationMarkers.inProgress.hide();

      if (!data.valid) {
        validationMarkers.failed.show();
        var errors = '<li>' + data.errors.join('</li><li>') + '</li>';
        validationErrorsList.html(errors);
      } else {
        validationMarkers.ok.show();
      }

      publishSubmitBtn.prop('disabled', false);
    });
  });
})()
