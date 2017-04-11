habitats = [];
foods = [];
animals = [];

function loadHabitats() {
  $('#habitat-select').html('<option value="None">None</option>');
  habitats.forEach(function(h) {
    $('#habitat-select').append([
      '<option ',
      $.query.get('habitat') == h.name ? 'selected ' : ' ',
      'value="',
      h.name,
      '">',
      h.name,
      '</option>'
    ].join(''));
  });
  $('#habitat-select').change(function() {
    if ($(this).val() === 'None') {
      $.query.SET('habitat');
    } else {
      $.query.SET('habitat', $(this).val());
    }
    if (_.isEmpty($.query.toString())) {
      window.location = '?';
    } else {
      window.location = $.query.toString();
    }
  });
}

function loadFoods() {
  $('#food-select').html('<option value="None">None</option>');
  foods.forEach(function(f) {
    $('#food-select').append([
      '<option ',
      $.query.get('food') == f.name ? 'selected ' : ' ',
      'value="',
      f.name,
      '">',
      f.name,
      '</option>'
    ].join(''));
  });
  $('#food-select').change(function() {
    if ($(this).val() === 'None') {
      $.query.REMOVE('food');
    } else {
      $.query.SET('food', $(this).val());
    }
    if (_.isEmpty($.query.toString())) {
      window.location = '?';
    } else {
      window.location = $.query.toString();
    }
  });
}

$(document).ready(function() {
  $.getJSON('/v1/tags?typ=0', function(data) {
    habitats = data;
    loadHabitats();
  });
  $.getJSON('/v1/tags?typ=1', function(data) {
    foods = data;
    loadFoods();
  });

  $.ajax({
    url: '/v1/animals',
    data: {
      habitat: _.isEmpty($.query.get('habitat')) ?
        undefined : $.query.get('habitat'),
      food: _.isEmpty($.query.get('food')) ?
        undefined : $.query.get('food'),
    },
    success: function(data) {
      animals = data;
      data.forEach(function(d) {
        d.images.forEach(function(img) {
          let container = $('#gallery').append([
            '<div class="col-md-3">',
            '<a href="javascript:void(0)" class="thumbnail" data-animal="',
            d.id,
            '">',
            '<img src="',
            img.filename,
            '">',
            '</a></div>'
          ].join(''));
        });
      });
      $('#gallery .thumbnail').each(function(i) {
        $(this).click(function() {
          let id = parseInt($(this).attr('data-animal'), 10);
          let a = _.findIndex(animals, {
            id: id
          });
          $('#modal-view-image img').attr('src',
            $(this).children().attr('src'));
          $('#animal-name').text(animals[a].name);
          $('#animal-habitat').text(animals[a].habitat);
          $('#animal-food').text(animals[a].food);
          $('#animal-description').text(animals[a].detail);

          $('#modal-view-image').modal('show');
        });
      });
    }
  });

  $('#btn-upload').click(function() {
    $('#modal-new-image input').val('');
    $('#modal-new-image').modal('show');
  });

  $('#btn-commit-upload').click(function() {
    $('#new_animal_name').val(
      $('#modal-new-image input[name="name"]').val());
    $('#new_animal_habitat').val(
      $('#modal-new-image input[name="habitat"]').val());
    $('#new_animal_food').val(
      $('#modal-new-image input[name="food"]').val());
    $('#new_animal_description').val(
      $('#modal-new-image input[name="description"]').val());

    $.ajax({
      url: '/albums/upload',
      type: 'POST',
      data: new FormData($('#modal-new-image form')[0]),
      success: function(image) {
        location.reload();
      },
      error: function(e) {
        console.log(e.responseJSON.message);
      },
      contentType: false,
      processData: false,
    });
  });
});
