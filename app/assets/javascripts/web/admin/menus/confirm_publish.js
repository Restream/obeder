(function() {
  var publishForm = $('#publish_form');
  var publishBtn = $('#publish_btn');
  var validationUrl = publishForm.attr('validationUrl');

  console.log(validationUrl);

  publishBtn.click(function(e) {
    $.get(validationUrl, function(data) {
      console.log(data);
    });
    e.preventDefault();
  });
})()
