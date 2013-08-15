$(document).ready ->
  $('.datetimepicker').datetimepicker({
     language: 'en',
     pick12HourFormat: true,
     startDate: new Date()
  });